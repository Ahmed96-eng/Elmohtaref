import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';

class ChangeLocationMap extends StatefulWidget {
  @override
  _ChangeLocationMapState createState() => _ChangeLocationMapState();
}

class _ChangeLocationMapState extends State<ChangeLocationMap> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    var cubit = AppCubit.get(context);
    cubit.orginMarker();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);

            return Scaffold(
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  GoogleMap(
                    padding: EdgeInsets.only(bottom: height * 0.1),
                    mapType: MapType.normal,
                    // compassEnabled: true,
                    // buildingsEnabled: true,
                    rotateGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    scrollGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    markers: Set<Marker>.of(homeCubit.markers.values),
                    // initialCameraPosition: homeCubit.kGooglePlex,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentPosition!.latitude,
                          currentPosition!.longitude),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onTap: (latLng) async {
                      print("ccccccccccccc1111111-->$currentPosition");
                      setState(() {
                        homeCubit.orginMarker();
                      });
                      homeCubit
                          .getCurrentLocationFromLatLng(
                            curentLatitude: latLng.latitude,
                            curentLongitude: latLng.longitude,
                          )
                          .then(
                              (value) => homeCubit.getCurrentAddressFromLatLng(
                                    curentLatitude: latLng.latitude,
                                    curentLongitude: latLng.longitude,
                                  ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: CommonButton(
                      text: "done".tr,
                      fontSize: width * 0.04,
                      width: width * 0.85,
                      // height: height * 0.05,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        back(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
