import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/no_data_widget.dart';
import 'package:mohtaref_client/view/components_widget/order/order_item.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var orderData = AppCubit.get(context).ordersModel == null
                ? []
                : AppCubit.get(context).ordersModel!.data!;
            return Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.15,
                  color: mainColor,
                  padding: EdgeInsets.symmetric(vertical: height * 0.05),
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Text(
                    "my_orders".tr,
                    style: thirdLineStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: orderData.length != 0
                      ? ListView.builder(
                          itemCount: orderData.length,
                          itemBuilder: (context, index) {
                            return OrderItems(
                              width: width,
                              height: height,
                              order: orderData[index],
                            );
                          },
                        )
                      : NoDataWidget(width: width, height: height * 0.4),
                ),
              ],
            );
          });
    });
  }
}
