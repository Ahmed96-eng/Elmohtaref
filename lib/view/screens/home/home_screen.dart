import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/home/change_location_map.dart';
import 'package:mohtaref_client/view/screens/home/search_screen.dart';
import 'package:mohtaref_client/view/screens/home/tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  // final Completer<GoogleMapController> _controller = Completer();
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final newLocationController = TextEditingController();
  final couponController = TextEditingController();
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
          if (state is CreateTaskLoadingState) showLoadingDialog(context);
        }, builder: (context, state) {
          // mohtarefClientId = CachedHelper.getData(key: mohtarefClientIdKey);
          // print("mohtarefClientIdKey is---> $mohtarefClientId");
          var homeCubit = AppCubit.get(context);
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            newLocationController.text = currentAddress ?? "change_location".tr;
          });

          return
              //  Scaffold(
              //   resizeToAvoidBottomInset: true,
              //   key: _scaffoldKey,
              //   // drawer: DrawerWidget(),
              //   body:
              Column(
            children: [
              // map

              // Container(
              //   height: height * 0.48,
              //   width: width,
              //   child: Stack(
              //     // alignment: AlignmentDirectional.topCenter,
              //     children: [
              //       GoogleMap(
              //         mapType: MapType.normal,
              //         // myLocationButtonEnabled: true,
              //         // myLocationEnabled: true,
              //         scrollGesturesEnabled: false,
              //         zoomControlsEnabled: false,
              //         initialCameraPosition: homeCubit.kGooglePlex,
              //         onMapCreated: (GoogleMapController controller) {
              //           _controller.complete(controller);
              //           // homeCubit.getCurrentPosition();
              //         },
              //       ),

              //       // /// profile icon
              //       // Align(
              //       //     alignment: AlignmentDirectional.topEnd,
              //       //     child: Padding(
              //       //       padding: EdgeInsets.symmetric(
              //       //           horizontal: width * 0.02,
              //       //           vertical: height * 0.05),
              //       //       child: Badge(
              //       //           value: "2",
              //       //           color: redColor,
              //       //           child: InkWell(
              //       //             onTap: () {
              //       //               print('profile');
              //       //               goTo(context, AccountScreen());
              //       //             },
              //       //             child: CircleAvatar(
              //       //               radius: 25,
              //       //             ),
              //       //           )),
              //       //     )),
              //       // profile icon
              //       Align(
              //           alignment: AlignmentDirectional.topStart,
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: width * 0.02,
              //                 vertical: height * 0.05),
              //             // child: Badge(
              //             //     value: "0",
              //             //     color: redColor,
              //             child: InkWell(
              //               onTap: () {
              //                 print('profile');
              //                 goTo(context, AccountScreen());
              //               },
              //               child: CircleAvatar(
              //                   radius: width * 0.08,
              //                   backgroundColor: redColor,
              //                   child: ClipOval(
              //                     child: CachedNetworkImageWidget(
              //                       // height: height * 0.08,
              //                       // width: width * 0.15,
              //                       boxFit: BoxFit.contain,
              //                       image: homeCubit
              //                           .profilModel!.data!.profile!,
              //                     ),
              //                     // ),
              //                   )),
              //             ),
              //           )),

              //       /// Drawer
              //       Align(
              //           alignment: AlignmentDirectional.topStart,
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: width * 0.02,
              //                 vertical: height * 0.05),
              //             child: IconButtonWidget(
              //               icon: Icons.menu_outlined,
              //               onpressed: () =>
              //                   _scaffoldKey.currentState!.openDrawer(),
              //             ),
              //           )),

              //       /// logo icon

              //       Align(
              //         alignment: AlignmentDirectional.center,
              //         child: Container(
              //           width: width / 2,
              //           margin: EdgeInsets.only(bottom: height * 0.08),
              //           decoration: new BoxDecoration(
              //             color: mainColor,
              //             borderRadius:
              //                 BorderRadius.circular(width * 0.02),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.8),
              //                 // spreadRadius: 10,
              //                 blurRadius: height * 0.02,
              //                 offset: Offset(
              //                     0,
              //                     height *
              //                         0.05), // changes position of shadow
              //               ),
              //             ],
              //             image: new DecorationImage(
              //               fit: BoxFit.fitWidth,

              //               // colorFilter: new ColorFilter.mode(
              //               //     Colors.black.withOpacity(0.3),
              //               // BlendMode.dstATop),
              //               image: new AssetImage(
              //                 "asset/images/main_logo.png",
              //               ),
              //             ),
              //           ),
              //         ),
              //         // child: Image.asset(
              //         //   "asset/images/main_logo.png",
              //         //   height: height * 0.3, width: width,
              //         //   // colorBlendMode: BlendMode.dst,
              //         // ),
              //       ),
              //     ],
              //   ),
              // ),

              // slider

              CarouselSlider(
                items: homeCubit.sliderModel!.data!.map(
                  (e) {
                    return e.image != ""
                        ? GridTile(
                            child: CachedNetworkImageWidget(
                              height: height,
                              width: width,
                              image: e.image,
                            ),
                            footer: e.title != ""
                                ? Container(
                                    height: height * 0.1,
                                    color: Colors.black26,
                                    child: Center(
                                        child: Text(
                                      e.title!,
                                      style: firstLineStyle,
                                    )),
                                  )
                                : Container(),
                          )
                        : Container(
                            height: height * 0.1,
                            color: Colors.black26,
                            child: Center(
                                child: Text(
                              e.title!,
                              style: firstLineStyle,
                            )),
                          );
                  },
                ).toList(),
                options: CarouselOptions(
                  height: height * 0.35,
                  aspectRatio: 3 / 4,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              // search
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: InkWell(
                  onTap: () {
                    AppCubit.get(context)
                        .searchOfServices(
                          serviceName: "",
                        )
                        .then((value) => goTo(context, SearchScreen()));
                  },
                  child: FixedTextField(
                    width: width,
                    height: height * 0.3,
                    hint: "search_hint".tr,
                    radiusValue: width * 0.02,
                    isSearch: true,
                    icon: Icons.search,
                    iconColor: mainColor,
                    enabled: false,
                  ),
                ),
              ),

              /// Services
              Expanded(
                // height: height * 0.35,
                // width: width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.01,
                    // vertical: height * 0.01,
                  ),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: homeCubit.servicesModel!.data!.length == 0
                        ? 0
                        : homeCubit.servicesModel!.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: width * 0.01,
                      mainAxisSpacing: height * 0.01,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Future.delayed(Duration(seconds: 1))
                              // homeCubit
                              //     .getProviders(
                              //   serviceId: homeCubit
                              //       .servicesModel!.data![index].id
                              //       .toString(),
                              //   lat: (currentPosition!.latitude).toString(),
                              //   long: (currentPosition!.longitude).toString(),
                              // )
                              .then((value) {
                            print(
                                "zzzzzzzzzzz------> ${currentPosition!.latitude},${currentPosition!.latitude}");
                            showAlertDailog(
                              context: context,
                              isContent: true,
                              contentWidget: Container(
                                // padding:
                                //     MediaQuery.of(context).viewInsets,
                                height: height * 0.55, width: width,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    FixedTextField(
                                      controller: newLocationController,
                                      width: width,
                                      height: height,
                                      radiusValue: width * 0.02,
                                      hint: "change_location".tr,
                                      icon: Icons.location_on_rounded,
                                      iconColor: mainColor,
                                      isSearch: true,
                                      onTap: () {
                                        goTo(context, ChangeLocationMap());
                                      },
                                    ),
                                    FixedTextField(
                                      controller: couponController,
                                      width: width,
                                      height: height,
                                      radiusValue: width * 0.02,
                                      hint: "promo_code".tr,
                                      icon: Icons.local_offer,
                                      iconColor: redColor,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    // SizedBox(
                                    //   height: height * 0.02,
                                    // ),
                                    FixedTextField(
                                      controller: titleController,
                                      width: width,
                                      height: height,
                                      radiusValue: width * 0.02,
                                      hint: "title".tr,
                                      icon: Icons.text_fields_rounded,
                                      iconColor: redColor,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    // SizedBox(
                                    //   height: height * 0.02,
                                    // ),
                                    FixedTextField(
                                      width: width,
                                      height: height,
                                      isBold: true,
                                      radiusValue: width * 0.1,
                                      hint: "fixed_fees".tr +
                                          " : " +
                                          homeCubit.servicesModel!.data![index]
                                              .serviceAmount
                                              .toString() +
                                          " " +
                                          "sar".tr,
                                      icon: Icons.paid_rounded,
                                      iconColor: redColor,
                                      enabled: false,
                                    ),
                                    // SizedBox(
                                    //   height: height * 0.02,
                                    // ),
                                    CommonButton(
                                      text: "done".tr,
                                      fontSize: width * 0.05,
                                      width: width * 0.85,
                                      containerColor: buttonColor,
                                      textColor: mainColor,
                                      onTap: () {
                                        back(context);
                                        print(
                                            "bbbbbbbbb1111NEW-->${currentPosition!.latitude}");
                                        print(
                                            "bbbbbbbbb2222NEW--->${currentPosition!.longitude}");
                                        print(
                                            "bbbbbbbbb2222NEW--->$currentAddress!");
                                        if (titleController.text == "" ||
                                            titleController.text.isEmpty) {
                                          showFlutterToast(
                                              message: "write_service_title".tr,
                                              backgroundColor: darkColor);
                                        } else {
                                          homeCubit
                                              .createTask(
                                                serviceId: homeCubit
                                                    .servicesModel!
                                                    .data![index]
                                                    .id
                                                    .toString(),
                                                lat: (currentPosition!.latitude)
                                                    .toString(),
                                                long:
                                                    (currentPosition!.longitude)
                                                        .toString(),
                                                coupon: couponController.text,
                                                title: titleController.text,
                                                location:
                                                    newLocationController.text,
                                              )
                                              .then(
                                                (value) => Future.delayed(
                                                        Duration(
                                                            milliseconds: 200))
                                                    .then((value) {
                                                  print(
                                                      "vvvvvvvvvvvvvvvv*******> ${homeCubit.servicesModel!.data![index].id}");
                                                  titleController.clear();
                                                  couponController.clear();
                                                  back(context);
                                                  goTo(
                                                      context,
                                                      TasksScreen(
                                                        // index: index,
                                                        servicesModelData:
                                                            homeCubit
                                                                .servicesModel!
                                                                .data![index],
                                                      ));
                                                }),
                                              );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // onPressNo: () {},
                              // onPressYes: () {},
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.25,
                              height: height * 0.12,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.05)),

                              child: Padding(
                                padding: EdgeInsets.all(width * 0.03),
                                child: CachedNetworkImageWidget(
                                  // width: width * 0.2,
                                  // height: height * 0.12,
                                  boxFit: BoxFit.contain,
                                  image: homeCubit
                                      .servicesModel!.data![index].serviceImg,
                                ),
                              ),
                              // child: Image.asset(
                              //   "asset/images/1.png",
                              //   // height: height * 0.28, width: width,
                              //   // colorBlendMode: BlendMode.dst,
                              // ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              homeCubit.servicesModel!.data![index].seviceName!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: (width * 0.015) * (height * 0.005),
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      );
                      // return ListTile(
                      //   title: CircleAvatar(),
                      //   subtitle: Text('data'),
                      // );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          );
        });
      },
    );
  }
}


// class BoxWidget extends StatelessWidget {
//   BoxWidget({
//     required this.width,
//     required this.height,
//   });

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(width * 0.1),
//           color: mainColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               offset: Offset(0.0, 1.0), //(x,y)
//               blurRadius: 6.0,
//             ),
//           ]),
//       width: width * 0.4,
//       height: height * 0.1,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "154.2",
//             style: thirdLineStyle,
//           ),
//           SizedBox(
//             width: width * 0.01,
//           ),
//           Text(
//             "sar".tr,
//             textAlign: TextAlign.justify,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InfoWidget extends StatelessWidget {
//   final IconData? icon;
//   final String? persentage;
//   final String? title;

//   InfoWidget({this.icon, this.persentage, this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: Container(
//       decoration: BoxDecoration(
//           border: Border(
//         left: BorderSide(
//           width: 1,
//           color: Colors.black12,
//         ),
//         top: BorderSide(
//           width: 1,
//           color: Colors.black12,
//         ),
//       )),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Icon(
//             icon,
//             color: redColor,
//           ),
//           Text(
//             persentage!,
//             style: lineStyleSmallBlack,
//           ),
//           Text(title!),
//           SizedBox(
//             height: 5,
//           ),
//         ],
//       ),
//     ));
//   }
// }
