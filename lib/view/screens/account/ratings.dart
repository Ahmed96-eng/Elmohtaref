import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/no_data_widget.dart';
import 'package:mohtaref_client/view/components_widget/rating_widget.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Ratings extends StatelessWidget {
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
              backgroundColor: thirdColor,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "rating".tr,
                    width: width,
                    closeIcon: true,
                  )),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    height: height / 3,
                    color: mainColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(homeCubit.profilModel!.data!.rate!,
                                style: secondLineStyle),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            RatingMethodWidget(
                              width: width,
                              initialRating: double.parse(
                                  homeCubit.profilModel!.data!.rate!),
                              onRatingUpdate: (value) {},
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text("total_task".tr, style: stylegrey),
                          ],
                        )),
                        Expanded(
                          child: CircularPercentIndicator(
                            radius: width * 0.4,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: width * 0.03,
                            percent: 0.4,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    homeCubit.profilModel!.data!.numberTasks
                                        .toString(),
                                    style: thirdLineStyle),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text("total_task".tr, style: stylegrey),
                              ],
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: thirdColor!,
                            progressColor: Colors.red,
                            addAutomaticKeepAlive: true,
                            animateFromLastPercent: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.02,
                    ),
                    child: Text(
                      "my_orders".tr,
                      style: thirdLineStyle,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: mainColor,
                    child: homeCubit.ordersModel!.data!.length != 0
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: homeCubit.ordersModel!.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    homeCubit.ordersModel!.data![index].title!),
                                subtitle: Text(homeCubit
                                    .ordersModel!.data![index].staffName!),
                              );
                            },
                          )
                        : NoDataWidget(width: width, height: height * 0.3),
                  ))
                ],
              ),
            );
          });
    });
  }
}
