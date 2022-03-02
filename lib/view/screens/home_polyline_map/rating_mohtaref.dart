import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/model/providers_model.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/rating_widget.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/home_polyline_map/details_screen.dart';

class RatingUser extends StatelessWidget {
  final ProvidersModelData? providersModelData;

  const RatingUser({this.providersModelData});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                showFlutterToast(
                    message: "no_back".tr, backgroundColor: redColor);
                return false;
              },
              child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                        child: Container(
                      width: width,
                      height: height,
                      color: greyColor,
                      child: Image.asset(
                        "asset/images/main_logo.png",
                        fit: BoxFit.fill,
                      ),
                    )),
                    Container(
                      height: height * 0.35,
                      width: width,
                      color: mainColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "how_was_your_mohtaref".tr,
                            style: thirdLineStyle,
                          ),
                          Text(
                            providersModelData!.userName!,
                            style: secondLineStyle,
                          ),
                          RatingMethodWidget(
                            width: width,
                            initialRating:
                                double.parse(providersModelData!.rate!),
                            ignoreGestures: false,
                            onRatingUpdate: (rate) {
                              homeCubit.swapRate(rate);
                            },
                          ),
                          CommonButton(
                              width: width * 0.85,
                              height: height * 0.08,
                              containerColor: redColor,
                              textColor: mainColor,
                              fontSize: width * 0.05,
                              text: "rate_mohtaref".tr,
                              onTap: () {
                                print(
                                    "tttttttttttttttttt${homeCubit.rateValue}");
                                print(
                                    "tttttttttttttttttt${providersModelData!.rate}");
                                homeCubit.rateValue == 0
                                    ? goTo(context, DetailsScreen())
                                    : homeCubit
                                        .rateMohtaref(
                                        mohtarefId: providersModelData!.id,
                                        rate: homeCubit.rateValue,
                                      )
                                        .then((value) {
                                        goTo(context, DetailsScreen());
                                        homeCubit.rateValue = 0;
                                      });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
