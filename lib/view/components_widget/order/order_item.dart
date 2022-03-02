import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref_client/model/orders_model.dart';
import 'package:get/get.dart';

import '../../../constant.dart';

class OrderItems extends StatefulWidget {
  final OrdersModelData? order;

  final double? width;
  final double? height;
  const OrderItems({Key? key, this.order, this.width, this.height})
      : super(key: key);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
          // print(widget.order!.createdAt);
          // print(_expanded);
        });
      },
      child: Card(
        margin: EdgeInsets.all(widget.width! * 0.02),
        child: Column(
          children: <Widget>[
            ListTile(
              hoverColor: redColor,
              title: Text(widget.order!.title!),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("staff_name".tr + " : " + widget.order!.staffName!),
                  Text(Jiffy(widget.order!.createdAt!).MMMMEEEEd),
                ],
              ),
              trailing: Text(widget.order!.totalAmount! + " " + "sar".tr),
            ),
            Center(
                child: Icon(
              _expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
              size: widget.width! * 0.08,
            )),
            Divider(
              height: widget.height! * 0.01,
            ),
            _expanded
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    height: widget.height! * 0.2,
                    child: ListView(
                      children: [
                        Text(
                            "staff_name".tr + " : " + widget.order!.staffName!),
                        Text("staff_number".tr +
                            " : " +
                            widget.order!.staffNumber!),
                        Text("items".tr +
                            " : " +
                            widget.order!.items! +
                            " " +
                            "sar".tr),
                        Text("vat".tr +
                            " : " +
                            widget.order!.vat! +
                            " " +
                            "sar".tr),
                        Text("total".tr +
                            " : " +
                            widget.order!.totalAmount! +
                            " " +
                            "sar".tr),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
