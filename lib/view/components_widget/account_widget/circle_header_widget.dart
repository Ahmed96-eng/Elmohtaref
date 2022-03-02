import 'package:flutter/material.dart';

import '../style.dart';

class CircleHeaderWidget extends StatelessWidget {
  const CircleHeaderWidget({
    Key? key,
    required this.width,
    required this.height,
    this.image = "",
    this.title = "",
    // this.rating = 1,
    // this.isStack = false,
  }) : super(key: key);

  final double width;
  final double height;
  final String image;
  final String title;
  // final double? rating;

  // final bool isStack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: height * 0.05),
      child: GridTile(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.15),
              child: CircleAvatar(
                radius: width * 0.5,
                backgroundImage: NetworkImage(
                  "https://el-mohtaref.com/$image",
                ),
              ),
            ),
            // isStack
            //     ? Container(
            //         margin: EdgeInsets.only(bottom: height * 0.2),
            //         height: height * 0.15,
            //         width: width * 0.55,
            //         color: mainColor,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Text(rating.toString()),
            //             Icon(
            //               Icons.star,
            //               color: Colors.amber,
            //               size: width * 0.15,
            //             ),
            //           ],
            //         ),
            //       )
            //     : Container(),
          ],
        ),
        footer: Padding(
          padding: EdgeInsets.only(
            bottom: height * 0.05,
          ),
          child: Container(
              width: width,
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: firstLineStyle,
              )),
        ),
      ),
    );
  }
}
