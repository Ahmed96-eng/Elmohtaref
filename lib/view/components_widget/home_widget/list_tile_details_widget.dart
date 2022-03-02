import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class ListTileWalletWidget extends StatelessWidget {
  const ListTileWalletWidget({
    Key? key,
    required this.width,
    required this.height,
    this.title,
    this.amount,
    this.isTotal = false,
  }) : super(key: key);

  final double width;
  final double height;
  final String? title;
  final String? amount;
  final bool? isTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
      ),
      child: ListTile(
        title: Text(
          title!,
          style: TextStyle(
              fontSize: isTotal! ? width * 0.05 : width * 0.04,
              color: isTotal! ? redColor : Colors.black54,
              fontWeight: isTotal! ? FontWeight.bold : FontWeight.w400),
        ),
        trailing: Container(
          width: width * 0.2,
          // height: 50,
          child: Wrap(
            children: [
              Text(
                amount!.toString(),
                style: TextStyle(
                    fontSize: isTotal! ? width * 0.05 : width * 0.04,
                    color: isTotal! ? redColor : Colors.black54,
                    fontWeight: isTotal! ? FontWeight.bold : FontWeight.w400),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Text(
                "sar".tr,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: isTotal! ? width * 0.05 : width * 0.04,
                    color: isTotal! ? redColor : Colors.black54,
                    fontWeight: isTotal! ? FontWeight.bold : FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
