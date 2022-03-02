import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref_client/view/components_widget/icon_button_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/home/change_location_map.dart';
import 'package:mohtaref_client/view/screens/home/tasks_screen.dart';
import '../../../constant.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final newLocationController = TextEditingController();
  final couponController = TextEditingController();
  final titleController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            var searchData = AppCubit.get(context).searchModel?.data;
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              newLocationController.text =
                  currentAddress ?? "change_location".tr;
            });
            return Scaffold(
              key: _scaffoldKey,
              body: Container(
                margin: EdgeInsets.all(width * 0.02),
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                width: width,
                height: height,
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (lang == 'en')
                          IconButtonWidget(
                            icon: (lang == 'ar')
                                ? Icons.arrow_forward
                                : Icons.arrow_back,
                            radius: width * 0.05,
                            size: width * 0.05,
                            circleAvatarColor: redColor,
                            borderColor: redColor,
                            iconColor: mainColor,
                            onpressed: () {
                              back(context);
                              AppCubit.get(context).searchModel!.data!.length =
                                  0;
                            },
                          ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            autofocus: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02, vertical: 3),
                              fillColor: mainColor,
                              filled: true,
                              hintText: 'search'.tr,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: redColor!, width: width * 0.005),
                                borderRadius:
                                    BorderRadius.circular(width * 0.2),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: redColor!, width: width * 0.005),
                                borderRadius:
                                    BorderRadius.circular(width * 0.2),
                              ),
                            ),
                            onEditingComplete: () {
                              AppCubit.get(context).searchOfServices(
                                serviceName: searchController.text,
                              );
                              searchController.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        IconButtonWidget(
                          icon: Icons.search,
                          radius: width * 0.05,
                          size: width * 0.05,
                          circleAvatarColor: redColor,
                          borderColor: redColor,
                          iconColor: mainColor,
                          onpressed: () {
                            AppCubit.get(context).searchOfServices(
                              serviceName: searchController.text,
                            );
                            searchController.clear();
                          },
                        ),
                        SizedBox(
                          width: width * 0.08,
                        ),
                        if (lang == 'ar')
                          IconButtonWidget(
                            icon: (lang == 'ar')
                                ? Icons.arrow_forward
                                : Icons.arrow_back,
                            radius: width * 0.05,
                            size: width * 0.05,
                            circleAvatarColor: redColor,
                            borderColor: redColor,
                            iconColor: mainColor,
                            onpressed: () {
                              back(context);
                              AppCubit.get(context).searchModel?.data!.length =
                                  0;
                            },
                          ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    if (state is SearchOfServiceLoadingState)
                      LinearProgressIndicator(
                        color: redColor,
                        minHeight: height * 0.01,
                      ),
                    if (searchData!.length == 0)
                      NoDataWidget(
                        width: width * 1.2,
                        height: height * 0.3,
                      ),
                    if (state is SearchOfServiceSuccessState)
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        homeCubit
                                            .getProviders(
                                          // serviceId: homeCubit
                                          // .servicesModel!.data![index].id
                                          // .toString(),
                                          lat: (currentPosition!.latitude)
                                              .toString(),
                                          long: (currentPosition!.longitude)
                                              .toString(),
                                        )
                                            .then((value) {
                                          // back(context);
                                          showAlertDailog(
                                            context:
                                                _scaffoldKey.currentContext!,
                                            isContent: true,
                                            contentWidget: Container(
                                              // padding:
                                              //     MediaQuery.of(context).viewInsets,
                                              // height: height * 0.55,
                                              child: ListView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                children: [
                                                  FixedTextField(
                                                    controller:
                                                        newLocationController,
                                                    width: width,
                                                    height: height,
                                                    radiusValue: width * 0.02,
                                                    hint: "change_location".tr,
                                                    icon: Icons
                                                        .location_on_rounded,
                                                    iconColor: mainColor,
                                                    isSearch: true,
                                                    onTap: () {
                                                      goTo(
                                                          _scaffoldKey
                                                              .currentContext!,
                                                          ChangeLocationMap());
                                                    },
                                                  ),
                                                  FixedTextField(
                                                    controller:
                                                        couponController,
                                                    width: width,
                                                    height: height,
                                                    radiusValue: width * 0.02,
                                                    hint: "promo_code".tr,
                                                    icon: Icons.local_offer,
                                                    iconColor: redColor,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                  ),
                                                  FixedTextField(
                                                    controller: titleController,
                                                    width: width,
                                                    height: height,
                                                    radiusValue: width * 0.02,
                                                    hint: "title".tr,
                                                    icon: Icons
                                                        .text_fields_rounded,
                                                    iconColor: redColor,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                  ),
                                                  // SizedBox(
                                                  //   height: height * 0.02,
                                                  // ),
                                                  FixedTextField(
                                                    width: width,
                                                    height: height,
                                                    radiusValue: width * 0.1,
                                                    hint: "fixed_fees".tr +
                                                        " : " +
                                                        homeCubit
                                                            .servicesModel!
                                                            .data![index]
                                                            .serviceAmount
                                                            .toString() +
                                                        " " +
                                                        "sar".tr,
                                                    icon: Icons.paid_rounded,
                                                    iconColor: redColor,
                                                    enabled: false,
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  CommonButton(
                                                    text: "done".tr,
                                                    fontSize: width * 0.05,
                                                    width: width * 0.85,
                                                    containerColor: buttonColor,
                                                    textColor: mainColor,
                                                    onTap: () {
                                                      back(
                                                        _scaffoldKey
                                                            .currentContext!,
                                                      );
                                                      print(
                                                          "bbbbbbbbb1111NEW-->${currentPosition!.latitude}");
                                                      print(
                                                          "bbbbbbbbb2222NEW--->${currentPosition!.longitude}");
                                                      print(
                                                          "bbbbbbbbb2222NEW--->$currentAddress!");
                                                      if (titleController
                                                                  .text ==
                                                              "" ||
                                                          titleController
                                                              .text.isEmpty) {
                                                        showFlutterToast(
                                                            message:
                                                                "write_service_title"
                                                                    .tr,
                                                            backgroundColor:
                                                                darkColor);
                                                      } else {
                                                        homeCubit
                                                            .createTask(
                                                              serviceId: homeCubit
                                                                  .servicesModel!
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                              lat: (currentPosition!
                                                                      .latitude)
                                                                  .toString(),
                                                              long: (currentPosition!
                                                                      .longitude)
                                                                  .toString(),
                                                              coupon:
                                                                  couponController
                                                                      .text,
                                                              title:
                                                                  titleController
                                                                      .text,
                                                              location:
                                                                  newLocationController
                                                                      .text,
                                                            )
                                                            .then(
                                                              (value) => Future.delayed(
                                                                      Duration(
                                                                          milliseconds:
                                                                              200))
                                                                  .then(
                                                                      (value) {
                                                                titleController
                                                                    .clear();
                                                                couponController
                                                                    .clear();
                                                                goTo(
                                                                    _scaffoldKey
                                                                        .currentContext!,
                                                                    TasksScreen(
                                                                      servicesModelData: homeCubit
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
                                      child: Container(
                                        width: width * 0.25,
                                        height: height * 0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                                width * 0.05)),
                                        child: Padding(
                                          padding: EdgeInsets.all(width * 0.03),
                                          child: CachedNetworkImageWidget(
                                            boxFit: BoxFit.contain,
                                            image:
                                                searchData[index].serviceImage!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Text(
                                      searchData[index].serviceName!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (width * 0.017) * (height * 0.006),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.all(width * 0.03),
                                    child: Divider(),
                                  ),
                              itemCount: searchData.length)),
                  ],
                ),
              ),
            );
          });
    });
  }
}
