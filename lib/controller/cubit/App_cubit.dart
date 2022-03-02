import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohtaref_client/controller/api_dio_helper/dio_helper.dart';
import 'package:mohtaref_client/controller/api_dio_helper/endpoint_dio.dart';
import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mohtaref_client/model/charge_wallet_model.dart';
import 'package:mohtaref_client/model/contacts_model.dart';
import 'package:mohtaref_client/model/create_task_model.dart';
import 'package:mohtaref_client/model/due_amount_model.dart';
import 'package:mohtaref_client/model/messsage_model.dart';
import 'package:mohtaref_client/model/orders_model.dart';
import 'package:mohtaref_client/model/profile_model.dart';
import 'package:mohtaref_client/model/providers_model.dart';
import 'package:mohtaref_client/model/search_model.dart';
import 'package:mohtaref_client/model/services_model.dart';
import 'package:mohtaref_client/model/slider_model.dart';
import 'package:mohtaref_client/model/task_details_model.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/screens/Wallet/wallet_screen.dart';
import 'package:mohtaref_client/view/screens/account/account_screen.dart';
import 'package:mohtaref_client/view/screens/home/home_screen.dart';
import 'package:mohtaref_client/view/screens/orders/orders_screen.dart';
import 'package:get/get.dart' as getTranslat;
import 'package:path_provider/path_provider.dart';
import '../../constant.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  onInit() {
    CachedHelper.getData(key: loginTokenId);
  }

  /// start refresh
  void refresh() {
    emit(RefreshState());
  }

  /// end refresh
  ///
  ///
  /// start delete cached TemporaryDirectory

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      print("deleteTemporaryDirectory true success");
    }
    // final appDir = await getApplicationSupportDirectory();
    // if (appDir.existsSync()) {
    //   appDir.deleteSync(recursive: true);
    //   print("deleteApplicationSupportDirectory true success");
    // }
  }

  /// end delete cached TemporaryDirectory
  ///
  ///
  /// Start bottom navbar functions
  int currentIndex = 0;
  Color? selectedColor = redColor;

  List<Widget> screens = [
    HomeScreen(),
    OrdersScreen(),
    WalletScreen(),
    AccountScreen(),
  ];
  backToCurrentIndex() {
    emit(AppChangeBottomNavBarState());
    currentIndex = 0;
  }

  Future<bool> willPopScop(context) {
    emit(AppChangeBottomNavBarState());
    return currentIndex == 1
        ? [currentIndex = 0, selectedColor = redColor]
        : currentIndex == 2
            ? [currentIndex = 0, selectedColor = redColor]
            : currentIndex == 3
                ? [currentIndex = 0, selectedColor = redColor]
                : back(context);
  }

  void changeBottomnavBarIndex(int index, context) {
    currentIndex = index;

    emit(AppChangeBottomNavBarState());
  }

  bool cancelTaskExpand = false;
  void changeCancelTaskExpand(BuildContext context) {
    cancelTaskExpand = !cancelTaskExpand;
    emit(ChangeCancelTaskExpandState());
  }

  // bool storesExpand = false;
  // void changeStoresExpand(BuildContext context) {
  //   storesExpand = !storesExpand;
  //   emit(ChangeStoresExpandState());
  // }

  // String changeListTileValue = '';
  // void changechangeListTileValue(
  //     BuildContext context, dynamic value, dynamic finalValue) {
  //   finalValue = value!;
  //   emit(ChangeListTileValueState());
  // }

  /// End bottom navbar functions

  // bool goExpand = false;
  // void changeGoExpand(BuildContext context) {
  //   goExpand = !goExpand;
  //   emit(ChangeGoExpandState());
  // }

  ///  Start notificationToggle

  bool notificationToggle = true;
  void changenotificationToggle(BuildContext context, bool notificationValue) {
    notificationToggle = notificationValue;
    if (notificationToggle) {
      FirebaseMessaging.instance.subscribeToTopic('customers');
      print("subscribeToTopic");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic('customers');
      print("UNsubscribeToTopic");
    }
    emit(ChangeNotificationToggleState());
  }

  // bool confirmNotificationAlert = false;
  // void confirmNotificationAlertExpand(BuildContext context) {
  //   confirmNotificationAlert = !confirmNotificationAlert;
  //   emit(ConfirmNotificationAlertState());
  // }

  ///  End notificationToggle
  ///
  ///
  ///  Start Map functions

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(29.9933611, 31.161301),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> mapController = Completer();
  GoogleMapController? googleMapController;
  // Position? currentPosition;
  String? destinationAddress;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  /// getCurrentPosition
  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngCameraPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngCameraPosition, zoom: 14);
    getCurrentAddressFromLatLng(
      curentLatitude: position.latitude,
      curentLongitude: position.longitude,
    );
    // getAddressFromLatLng(destLatitude!, destLongitude!);
    print('mmmmmmmmmmmmmaaaaapppps');
    print(currentPosition);
    print(cameraPosition);
    googleMapController = await mapController.future;
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  /// start MapCreated
  void onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    mapController.complete(controller);
    mapController.future;
  }

  /// end MapCreated
  // getAddressFromLatLng(double? curentLatitude, double? curentLongitude,
  //     double? destLatitude, double? destLongitude) async {
  //   try {
  //     print("start");
  //     List<Placemark> originPlacemarks =
  //         await placemarkFromCoordinates(curentLatitude!, curentLongitude!);
  // List<Placemark> destinationPlacemarks =
  //     await placemarkFromCoordinates(destLatitude!, destLongitude!);
  //     Placemark originPlace = originPlacemarks[0];
  //     Placemark destinationPlace = destinationPlacemarks[0];
  //     print("start1");
  //     currentAddress =
  //         "${originPlace.street},${originPlace.subAdministrativeArea}, ${originPlace.administrativeArea}, ${originPlace.country}";
  //     destinationAddress =
  //         "${destinationPlace.street},${destinationPlace.subAdministrativeArea}, ${destinationPlace.administrativeArea}, ${destinationPlace.country}";
  //     print("xxxxxxxxxxxxxbbbbbb " + "$currentAddress");
  //     print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$destinationAddress");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  /// start get current Location and Address from LatLng

  Future getCurrentLocationFromLatLng(
      {double? curentLatitude, double? curentLongitude}) async {
    currentPosition = Position(
        longitude: curentLongitude!,
        latitude: curentLatitude!,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);
    print("ccccccccccccc222222-->$currentPosition");
    orginMarker();
    emit(GetCurrentLocationFromLatLngSuccessState());
  }

  getCurrentAddressFromLatLng(
      {double? curentLatitude, double? curentLongitude}) async {
    List<Placemark> originPlacemarks =
        await placemarkFromCoordinates(curentLatitude!, curentLongitude!);
    Placemark originPlace = originPlacemarks[0];

    currentAddress =
        "${originPlace.street},${originPlace.subAdministrativeArea}, ${originPlace.administrativeArea}, ${originPlace.country}";

    print("cccccccccccccccxxxxxxxxxx-->$currentAddress");
    orginMarker();
    // addMarker(
    //   LatLng(curentLatitude, curentLongitude),
    //   "origin",
    //   BitmapDescriptor.defaultMarker,
    //   "Address",
    //   "${currentAddress!}",
    // );
    emit(GetCurrentAddressFromLatLngSuccessState());
  }

  getDestinationAddressFromLatLng(
      {double? destLatitude, double? destLongitude}) async {
    List<Placemark> destinationPlacemarks =
        await placemarkFromCoordinates(destLatitude!, destLongitude!);
    Placemark destinationPlace = destinationPlacemarks[0];

    destinationAddress =
        "${destinationPlace.street},${destinationPlace.subAdministrativeArea}, ${destinationPlace.administrativeArea}, ${destinationPlace.country}";

    print("cccccccccccccccxxxxxxxxxx-->$destinationAddress");

    emit(GetCurrentAddressFromLatLngSuccessState());
  }

  /// end get current Location and Address from LatLng

  Future<void> zoomToFit(LatLngBounds bounds, LatLng centerBounds) async {
    bool keepZoomingOut = true;

    while (keepZoomingOut) {
      final LatLngBounds screenBounds =
          await googleMapController!.getVisibleRegion();
      if (fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel =
            await googleMapController!.getZoomLevel() - 0.5;
        googleMapController!
            .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      } else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel =
            await googleMapController!.getZoomLevel() - 0.1;
        googleMapController!
            .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }

  // double destLatitude = 30.9933500, destLongitude = 31.1613109;

  addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      String title, String snipped) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
        infoWindow: InfoWindow(
          title: title,
          snippet: snipped,
        ));
    markers[markerId] = marker;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  orginMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset("asset/images/origin_pin.png", 100);
    addMarker(
      LatLng(currentPosition!.latitude, currentPosition!.longitude),
      "origin",
      BitmapDescriptor.fromBytes(markerIcon),
      "origin",
      "${currentAddress!}",
    );
  }

  destinationMarker({double? destLatitude, double? destLongitude}) async {
    final Uint8List markerIcon =
        await getBytesFromAsset("asset/images/destination_pin.png", 100);
    addMarker(
      LatLng(destLatitude!, destLongitude!),
      "destination",
      // BitmapDescriptor.defaultMarkerWithHue(90),
      BitmapDescriptor.fromBytes(markerIcon),
      "destination",
      "${destinationAddress!}",
    );
  }

  // double? getMarkerRotation() {
  //   dynamic rotation =toolKit. SphericalUtil.computeHeading(
  //  toolKit. LatLng(currentPosition!.latitude, currentPosition!.longitude),
  //   toolKit.  LatLng(destLatitude, destLongitude),
  //   );
  //   return rotation;
  // }

  addPolyLine(double? destLatitude, double? destLongitude) async {
    double originlat = currentPosition!.latitude;
    double originlng = currentPosition!.longitude;

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 5,
        consumeTapEvents: true,
        polylineId: id,
        color: redColor!,
        points: polylineCoordinates);
    polylines[id] = polyline;

    // zoom to current position
    LatLngBounds latLngBounds;
    LatLng destLatLng = LatLng(destLatitude!, destLongitude!);
    LatLng originLatLng = LatLng(originlat, originlng);
    if (originlat > destLatitude && originlng > destLongitude) {
      latLngBounds =
          LatLngBounds(southwest: destLatLng, northeast: originLatLng);
    } else if (originlat > destLatitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(destLatitude, originlng),
          northeast: LatLng(originlat, destLongitude));
    } else if (originlng > destLongitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(originlat, destLongitude),
          northeast: LatLng(destLatitude, originlng));
    } else {
      latLngBounds =
          LatLngBounds(southwest: originLatLng, northeast: destLatLng);
    }

// calculating centre of the bounds
    LatLng centerBounds = LatLng(
        (latLngBounds.northeast.latitude + latLngBounds.southwest.latitude) / 2,
        (latLngBounds.northeast.longitude + latLngBounds.southwest.longitude) /
            2);

// setting map position to centre to start with
    // cubit.googleMapController!
    //     .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   target: centerBounds,
    //   zoom: 17,
    // )));
    zoomToFit(latLngBounds, centerBounds);
    emit(AddPolyLineState());
  }

  getPolyline(double? destLatitude, double? destLongitude) async {
    double originlat = currentPosition!.latitude;
    double originlng = currentPosition!.longitude;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey,
      PointLatLng(originlat, originlng),
      PointLatLng(destLatitude!, destLongitude!),
      travelMode: TravelMode.driving,
      avoidFerries: true,
      avoidHighways: true,
      avoidTolls: true,
      optimizeWaypoints: true,
      wayPoints: [
        // PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria"),
      ],
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    addPolyLine(destLatitude, destLongitude);
  }

  Future resetPolyline() async {
    polylineCoordinates.clear();
    markers.clear();
    polylines.clear();

    emit(ResetPolyLineState());
  }

  /// End Map functions

  /// START GET PROFILE DATA
  ProfilModel? profilModel;
  Future getProfile(String id) async {
    try {
      emit(GetProfileLoadingState());
      await DioHelper.postData(endpoint: PROFILE, data: {
        "id": id,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);
          print(value.data["data"]["wallet"]);
          print('22222222222223');
          profilModel = (ProfilModel.fromJson(value.data));
          totalWalletAmount = double.parse(value.data["data"]["wallet"]);
          CachedHelper.setData(
              key: walletAmountKey,
              value: double.parse(value.data["data"]["wallet"]));
          emit(GetProfileSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetProfileErrorState());
    }
  }

  Future getProfileData() async {
    try {
      emit(GetProfileLoadingState());
      await DioHelper.postData(endpoint: PROFILE, data: {
        "id": mohtarefClientId,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);
          print(value.data["data"]["wallet"]);
          print('22222222222223');
          profilModel = (ProfilModel.fromJson(value.data));
          totalWalletAmount = double.parse(value.data["data"]["wallet"]);
          CachedHelper.setData(
              key: walletAmountKey,
              value: double.parse(value.data["data"]["wallet"]));
          emit(GetProfileSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetProfileErrorState());
    }
  }

  /// END GET PROFILE DATA
  ///
  ///
  ///START UPDATE PROFILE

  Future updateProfile({
    String? phone,
    String? location,
    File? profileFile,
  }) async {
    try {
      // String imageName = imageFile.path.split('/').last;
      emit(UpdateProfileLoadingState());
      print("profileImage00000000 is --> $profileImage");
      await DioHelper.postData(endpoint: UPDATEPROFILE, data: {
        "id": mohtarefClientId,
        "mobile": phone,
        "location": location,
        "profile": profileFile != null
            ? await MultipartFile.fromFile(profileFile.path,
                contentType: MediaType('image', 'png'),
                filename: profileFile.path.split('/').last)
            : profilModel!.data!.profile,
      }).then(
        (value) {
          print('start updating');
          print(value.data);
          print(value);
          print(value);

          print("profileImage is --> $profileImage");

          print('end updating');

          // profilModel = (ProfilModel.fromJson(value.data));

          emit(UpdateProfileSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(UpdateProfileErrorState());
    }
  }

  ///END UPDATE PROFILE
  ///
  ///
  /// Start DELETE ACCOUNT

  Future deleteAccount() async {
    try {
      emit(DeleteAccountLoadingState());
      await DioHelper.postData(endpoint: DELETEACCOUNT, data: {
        "id": mohtarefClientId,
      }).then(
        (value) {
          print('start DELETE ACCOUNT');

          emit(DeleteAccountSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(DeleteAccountErrorState());
    }
  }

  /// End DELETE ACCOUNT
  ///
  ///
  /// start change profile image

  final picker = ImagePicker();
  File? profileImage;
  Future getProfileImageSource({required ImageSource imageSource}) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      print('no_image_selected'.tr);
      emit(PickedProfileImageErrorState());
    }
  }

  Future getProfileImage(BuildContext context,
      {double? height, double? width}) async {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'picked_image_from'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.1,
                  ),
                  CommonButton(
                    text: "camera".tr,
                    textColor: buttonTextColor,
                    containerColor: buttonColor,
                    height: height,
                    width: width!,
                    onTap: () {
                      getProfileImageSource(imageSource: ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  CommonButton(
                    text: "gallery".tr,
                    textColor: buttonTextColor,
                    containerColor: buttonColor,
                    height: height,
                    width: width,
                    onTap: () {
                      getProfileImageSource(imageSource: ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// end change profile image
  ///
  ///
  /// start services

  ServicesModel? servicesModel;
  Future getServices() async {
    try {
      emit(AuthServicesLoadingState());

      await DioHelper.getData(
        endpoint: SERVICES,
      ).then(
        (value) {
          print(value.data);
          servicesModel = (ServicesModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          print(value.data);

          emit(AutServicesSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      if (userToken!.isNotEmpty || userToken != null)
        showFlutterToast(
            message: error.response!.data["message"],
            backgroundColor: redColor);
      emit(AuthServicesErrorState());
    }
  }

  /// end services
  ///
  ///
  /// start Get Contacts

  ContactsModel? contactsModel;
  Future<void> getContacts() async {
    try {
      emit(GetContactsLoadingState());
      await DioHelper.getData(
        endpoint: CONTACTS,
      ).then((value) {
        print("wwwwwwwwwwwwaaaaaaaaaaaaaaaaa--> ${value.data}");
        contactsModel = ContactsModel.fromJson(value.data);
        print("wwwwwwwwwwwwaaaaaaaaaaaaaaaaa000000000--> $contactsModel");
        emit(GetContactsSuccessState());
      });
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      if (userToken!.isNotEmpty || userToken != null)
        showFlutterToast(
            message: error.response!.data["message"],
            backgroundColor: redColor);
      emit(GetContactsErrorState());
    }
  }

  /// end Get Contacts
  ///
  ///
  /// START CHAT

  /// Send Message
  void sendMassage({
    String? recevierId,
    String? recevierName,
    String? recevierImage,
    String? message,
  }) {
    MessageModel messageModel = MessageModel(
      message: message,
      recevierId: recevierId,
      recevierName: recevierName,
      recevierImage: recevierImage,
      senderId: profilModel!.data!.id ?? mohtarefClientId,
      senderName: profilModel!.data!.username,
      senderImage: profilModel!.data!.profile,
      timeDate: DateTime.now().toString(),
    );

    FirebaseFirestore.instance
        .collection("chat")
        .doc(profilModel!.data!.id ?? mohtarefClientId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendSenderMessageSuccessState());
    }).catchError((error) {
      print('start error');
      print(error);
      print('finish error');
      emit(SendSenderMessageErrorState());
    });

    /// send message to firebase
    FirebaseFirestore.instance
        .collection("chat")
        .doc(recevierId!)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) async {
      /// send message to backend
      await DioHelper.postData(endpoint: CHAT, data: {
        "from": "0" + "${profilModel!.data!.id ?? mohtarefClientId}",
        "to": recevierId,
        "message": message,
      });
      // getSenderMessages();
      print("0" + "${profilModel!.data!.id ?? mohtarefClientId}");
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print('start error');
      print(error);
      print('finish error');
      emit(SendMessageErrorState());
    });
  }

  /// Get Messages
  List<MessageModel> messages = [];
  void getMessages(String recevierId) {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(recevierId)
        .collection("messages")
        .orderBy('timeDate')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print("77777777777777");
        // print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
        emit(GetMessagesSuccessState());
      });
    });
  }

  // List<MessageModel> senderMessages = [];
  Future getSenderMessages() async {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(profilModel!.data!.id)
        .collection("messages")
        .orderBy('timeDate')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print("77777777777777");
        // print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
        emit(GetSenderMessagesSuccessState());
      });
    });
  }

  /// Delete chat
  void deleteMessages(String recevierId) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('chat')
          .doc(recevierId)
          .collection("messages");
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        print("vvvvvvvvvvv${snapshots.docs}");
        await doc.reference.delete();
      }
      emit(DeleteMessagesSuccessState());
    } catch (error) {
      print(error);
      emit(DeleteMessagesErrorState());
    }
  }

  /// END CHAT
  ///
  ///
  /// start services providers

  List<ProvidersModelData>? providersList = [];
  ProvidersModel? providersModel;
  // int currentPage = 1;
  Future getProviders({
    String? lat,
    String? long,
    // String? serviceId,
    String? taskId,
    // bool isRefresh = false,
  }) async {
    try {
      emit(GetProvidersLoadingState());
      await DioHelper.postData(endpoint: PROVIDERS, data: {
        "lat": lat,
        "long": long,
        // "service_id": serviceId,
        "task_id": taskId,
        // "page": currentPage,
      }).then(
        (value) {
          // if (isRefresh) {
          //   currentPage = 1;
          // }
          // providersList = [];
          // providersModel!.data!.length = 0;
          print('111111111111115555---<${value.data}');
          // print(value.data);
          // print(value);
          // print('2222222222222355555---> $serviceId');
          providersModel = (ProvidersModel.fromJson(value.data));
          providersModel!.data!.forEach((element) {
            providersList!.add(element);
          });
          print(providersList!.length);
          // print('3333333333333355555---> ${providersModel!.data![0].id}');
          // if (isRefresh) {
          //   providersList = providersModel!.data!.provider!;
          // } else {
          // providersModel!.data!.provider!.forEach((element) {
          //   providersList!.add(element);
          // });
          // providersList!.add(providersModel!.data!.provider!);
          //   currentPage++;
          // }

          // print("wwwwwwwwwwwwwwww-->${providersList!.length}");
          // print("wwwwwwwwwwwwwwww-->${providersList![0].userName}");
          // print("wwwwwwwwwwwwwwww-->$currentPage");
          emit(GetProvidersSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetProvidersErrorState());
    }
  }

  /// end services providers
  ///
  ///
  ///START TIMER

  // int start = 1;
  Duration duration = Duration();
  Timer? timer;

  /// stop timer
  void stopTimer() {
    duration = Duration();
    timer!.cancel();
    emit(TimerCancelState());
  }

  /// start timer
  void startTimer() {
    final addSecond = 1;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      final seconds = duration.inSeconds + addSecond;
      duration = Duration(seconds: seconds);
      emit(TimerIncressState());
    });
  }

  /// END TIMER
  ///
  ///
  /// START Cancel Task

  Future cancelTask({String? mohtarefId, String? taskId}) async {
    try {
      emit(CancelTaskLoadingState());

      await DioHelper.postData(endpoint: CANCELTASK, data: {
        "task_id": taskId,
        "staff_id": mohtarefId,
        "state": '',
      }).then(
        (value) {
          print('lllllllllllllllll CANCEL SUCCESS');
          print(value);

          emit(CancelTaskSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CancelTaskErrorState());
    }
  }

  /// END Cancel Task
  ///
  ///
  /// start create task
  CreateTaskModel? createTaskModel;
  Future createTask({
    String? lat,
    String? long,
    String? serviceId,
    String? coupon,
    String? title,
    String? location,
  }) async {
    try {
      emit(CreateTaskLoadingState());
      await DioHelper.postData(endpoint: CREATETASK, data: {
        "lat": lat,
        "long": long,
        "customer_id": mohtarefClientId,
        "service_id": serviceId,
        "coupon": coupon,
        "title": title,
        "location": location,
      }).then(
        (value) {
          print('11111111111111---<${value.data}');
          print('22222222222223---> $value');
          createTaskModel = (CreateTaskModel.fromJson(value.data));
          // print('33333333333h333---> ${createTaskModel!.data}');
          emit(CreateTaskSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CreateTaskErrorState());
    }
  }

  /// end create task
  ///
  ///
  /// START delete Task

  Future deleteTask({String? taskId}) async {
    try {
      emit(DeleteTaskLoadingState());

      await DioHelper.postData(endpoint: DELETETASK, data: {
        "task_id": taskId,
        "customer_id": mohtarefClientId,
      }).then(
        (value) {
          print('lllllllllllllllll delete SUCCESS');
          print(value);

          emit(DeleteTaskSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(DeleteTaskErrorState());
    }
  }

  /// END Cancel Task
  ///
  ///
  ///Start SEARCH SERVICES

  SearchModel? searchModel;
  Future searchOfServices({String? serviceName}) async {
    try {
      emit(SearchOfServiceLoadingState());

      await DioHelper.postData(endpoint: SEARCH, data: {
        "search": serviceName,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);
          print('22222222222223');
          searchModel = (SearchModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          emit(SearchOfServiceSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SearchOfServiceErrorState());
    }
  }

  ///End SEARCH SERVICES
  ///
  ///
  ///Start Get Slider

  SliderModel? sliderModel;
  Future getSlider({String? serviceName}) async {
    try {
      emit(GetSliderLoadingState());

      await DioHelper.getData(
        endpoint: SLIDER,
      ).then(
        (value) {
          print('11111111111111 SLIDERRRRRRRRRRRRRRRRRRRRRR');
          print(value.data);
          print(value);
          print('22222222222223');
          sliderModel = (SliderModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          emit(GetSliderSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      if (userToken!.isNotEmpty || userToken != null)
        showFlutterToast(
            message: error.response!.data["message"],
            backgroundColor: redColor);
      emit(GetSliderErrorState());
    }
  }

  ///End Get Slider
  ///
  ///
  /// Start Rate Mohtaref

  double rateValue = 0;
  swapRate(double rate) {
    rateValue = rate;
    emit(RateMohtarefSwapState());
  }

  Future rateMohtaref({String? mohtarefId, double? rate}) async {
    try {
      emit(RateMohtarefLoadingState());
      await DioHelper.postData(endpoint: RATEMOHTAREF, data: {
        "staff_id": mohtarefId,
        "rate": rate,
      }).then(
        (value) {
          print('start Rate Mohtaref');

          emit(RateMohtarefSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(RateMohtarefErrorState());
    }
  }

  /// End Rate Customer
  ///
  ///
  ///start Add Funds

  ChargeWalletModel? chargeWalletModel;
  Future addFunds({
    String? cardNumber,
    String? cvc,
    String? expMonth,
    String? expYear,
    String? amount,
  }) async {
    try {
      emit(AddFundsLoadingState());
      await DioHelper.postData(endpoint: ADDFUNDS, data: {
        "customer_id": mohtarefClientId,
        "card_number": cardNumber,
        "cvc": cvc,
        "exp_month": expMonth,
        "exp_year": expYear,
        "amount": amount,
      }).then(
        (value) {
          print('start AddFunds');
          print('nnnnnnnnnnnnnnnnnnnnnnnn--> $value');

          chargeWalletModel = ChargeWalletModel.fromJson(value.data);
          print(
              'nnnnnvvvvvvvvvv--> ${{chargeWalletModel!.chargeWalletAmount!}}');
          totalWalletAmount =
              double.parse(chargeWalletModel!.chargeWalletAmount!);
          CachedHelper.setData(
              key: walletAmountKey,
              value: double.parse(chargeWalletModel!.chargeWalletAmount!));
          emit(AddFundsSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AddFundsErrorState());
    }
  }

  /// End Add Funds
  ///
  ///
  ///start Add Promotions

  Future addPromotions({
    String? code,
  }) async {
    try {
      emit(AddPromotionLoadingState());
      await DioHelper.postData(endpoint: PROMOTIONS, data: {
        "customer_id": mohtarefClientId,
        "code": code,
      }).then(
        (value) {
          print('start addPromotions');
          print('nnnnnnnnnnnnnnnnnnnnnnnn--> $value');

          chargeWalletModel = ChargeWalletModel.fromJson(value.data);
          print(
              'nnnnnvvvvvvvvvv--> ${{chargeWalletModel!.chargeWalletAmount!}}');
          totalWalletAmount =
              double.parse(chargeWalletModel!.chargeWalletAmount!);
          CachedHelper.setData(
              key: walletAmountKey,
              value: double.parse(chargeWalletModel!.chargeWalletAmount!));
          emit(AddPromotionSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AddPromotionErrorState());
    }
  }

  /// End Add Promotions
  ///
  ///
  /// start Orders

  OrdersModel? ordersModel;
  Future getOrders() async {
    try {
      emit(GetOrdersLoadingState());

      await DioHelper.postData(endpoint: ORDERS, data: {
        "customer_id": mohtarefClientId,
      }).then(
        (value) {
          print(value.data);
          ordersModel = (OrdersModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          print(value.data);

          emit(GetOrdersSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetOrdersErrorState());
    }
  }

  /// end Orders
  ///
  ///
  /// start Payments

  Future payment({
    required String taskId,
    required String paymentMethod,
    required String total,
    required String staffId,
  }) async {
    try {
      emit(PaymentsLoadingState());

      await DioHelper.postData(endpoint: PAYMENT, data: {
        "task_id": taskId,
        "payment_method": paymentMethod,
        "total": total,
        "customer_id": mohtarefClientId,
        "staff_id": staffId,
      }).then(
        (value) {
          print(value.data);
          print("000000000000000000000--> PAYMENT");
          emit(PaymentsSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(PaymentsErrorState());
    }
  }

  /// end Payments
  ///
  ///
  /// start CancelPayments

  DueAmountModel? dueAmountModel;
  Future cancelPayment({
    required String taskId,
    required String due,
    required String staffId,
  }) async {
    try {
      emit(CancelPaymentsLoadingState());

      await DioHelper.postData(endpoint: CANCELPAYMENT, data: {
        "task_id": taskId,
        "due": due,
        "customer_id": mohtarefClientId,
        "staff_id": staffId,
      }).then(
        (value) {
          print(value.data);
          dueAmountModel = DueAmountModel.fromJson(value.data);
          print("000000000000000000000--> CANCELPAYMENT");
          totalDueAmount = double.parse(dueAmountModel!.dueAmount!);
          CachedHelper.setData(
              key: dueAmountKey,
              value: double.parse(dueAmountModel!.dueAmount!));
          emit(CancelPaymentsSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CancelPaymentsErrorState());
    }
  }

  /// end CancelPayments
  ///
  ///
  /// START GET TaskDetails Data

  TaskDetailsModel? taskDetailsModel;
  Future getTaskDetails(String? taskId) async {
    try {
      emit(GetTaskDetailsDataLoadingState());
      await DioHelper.postData(endpoint: TASKSDETAILS, data: {
        "task_id": taskId,
      }).then(
        (value) {
          print('11111111111bbbbbbbb--> ');
          print(value.data);
          print(value);

          taskDetailsModel = (TaskDetailsModel.fromJson(value.data));
          print('222222222222bb--> ${taskDetailsModel!.data!.serviceAmount}');
          emit(GetTaskDetailsDataSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetTaskDetailsDataErrorState());
    }
  }

  /// END GET TaskDetails Data
  ///
  ///
  /// Start AcceptTask

  Future acceptTask({String? mohtarefId, String? taskId}) async {
    try {
      emit(AcceptTaskLoadingState());
      await DioHelper.postData(endpoint: ACCEPTSTAFF, data: {
        "staff_id": mohtarefId,
        "task_id": taskId,
      }).then(
        (value) {
          print('start AcceptTask ');

          emit(AcceptTaskSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AcceptTaskErrorState());
    }
  }

  /// End AcceptTask
  ///
  ///
  /// start cancelReason

  Future cancelReason({
    required String taskId,
    String? reason,
    String? note,
  }) async {
    try {
      emit(CancelReasonLoadingState());

      await DioHelper.postData(endpoint: CANCELREASON, data: {
        "task_id": taskId,
        "reason": reason,
        "note": note,
        "cancelled_by": "custommer",
      }).then(
        (value) {
          print(value.data);
          print("000000000000000000000--> CANCELREASON");
          emit(CancelReasonSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CancelReasonErrorState());
    }
  }

  /// end cancelReason
  ///
  ///
  /// start SendComplaint

  Future sendComplaint({
    required String? title,
    required String? description,
  }) async {
    try {
      emit(SendComplaintLoadingState());

      await DioHelper.postData(endpoint: SENDCOMPLAINT, data: {
        "id": mohtarefClientId,
        "title": title,
        "description": description,
        "created_by": "customer",
      }).then(
        (value) {
          print(value.data);
          print("000000000000000000000--> SendComplaint");
          emit(SendComplaintSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SendComplaintErrorState());
    }
  }

  /// end SendComplaint
}
