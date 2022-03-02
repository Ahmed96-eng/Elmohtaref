import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref_client/model/messsage_model.dart';
import 'package:mohtaref_client/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';

class SenderMessage extends StatelessWidget {
  const SenderMessage({
    Key? key,
    required this.messageModel,
    this.width,
    this.height,
  }) : super(key: key);

  final MessageModel? messageModel;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: EdgeInsets.all(width! * 0.02),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              margin: EdgeInsets.all(width! * 0.02),
              padding: EdgeInsets.all(width! * 0.02),
              decoration: BoxDecoration(
                  color: Colors.teal[200],
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(width! * 0.05),
                      topEnd: Radius.circular(width! * 0.05),
                      bottomStart: Radius.circular(width! * 0.05))),
              width: width! * 0.5,
              // height: 50,
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messageModel!.senderName!,
                      style: styleBlack,
                    ),
                    SizedBox(
                      height: height! * 0.01,
                    ),
                    Text(
                      messageModel!.message!,
                      style: firstLineStyle,
                    ),
                    SizedBox(
                      height: height! * 0.01,
                    ),
                    Text(
                      Jiffy(messageModel!.timeDate).fromNow(),
                      style: stylegrey,
                    ),
                  ],
                ),
              ),
            ),
            ClipOval(
              child: CachedNetworkImageWidget(
                width: width! * 0.08,
                height: height! * 0.045,
                boxFit: BoxFit.fill,
                image: messageModel!.senderImage != null
                    ? "${messageModel!.senderImage}"
                    : "https://s1.1zoom.me/big0/958/Closeup_Camera_lens_534116_1280x677.jpg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
