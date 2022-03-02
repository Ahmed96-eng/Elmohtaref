import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/chat_widget/reciver_message.dart';
import 'package:mohtaref_client/view/components_widget/chat_widget/sender_message.dart';
import 'package:mohtaref_client/view/components_widget/icon_button_widget.dart';
import '../../../constant.dart';

class ChatScreen extends StatelessWidget {
  final String? reciverId;
  final String? username;
  final String? userImg;

  ChatScreen({this.reciverId, this.username, this.userImg});
  final scrollController = ScrollController();
  final messsageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;

      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var appCubit = AppCubit.get(context);

            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "chat".tr,
                    width: width,
                    closeIcon: true,
                  )),
              body: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var message = appCubit.messages[index];

                        if (appCubit.profilModel!.data!.id == message.senderId)
                          return SenderMessage(
                            messageModel: message,
                            width: width,
                            height: height,
                          );
                        return ReceviedMessage(
                          messageModel: message,
                          width: width,
                          height: height,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: height * 0.005,
                      ),
                      itemCount: appCubit.messages.length,
                    ),
                  )..flex,
                  Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.01),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width * 0.01),
                                border: Border.all()),
                            child: TextField(
                              controller: messsageController,
                              decoration: InputDecoration(
                                  // suffixIcon: IconButtonWidget(
                                  //   icon: Icons.camera_alt,
                                  //   radius: width * 0.05,
                                  //   iconColor: redColor,
                                  //   circleAvatarColor: Colors.transparent,
                                  //   size: width * 0.05,
                                  //   onpressed: () {
                                  //     // AppCubit.get(context)
                                  //     //     .getChatImage(context);
                                  //   },
                                  // ),
                                  // // contentPadding: EdgeInsets.only(left: 5),
                                  hintText: "Write in your mind",
                                  fillColor: Colors.black12,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()),
                          child: IconButtonWidget(
                            icon: Icons.send_rounded,
                            iconColor: redColor,
                            circleAvatarColor: Colors.transparent,
                            radius: width * 0.05,
                            size: width * 0.06,
                            onpressed: () {
                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent +
                                      height * 0.2,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.bounceOut);
                              print("recevierId--> $reciverId");
                              appCubit.sendMassage(
                                  message: messsageController.text,
                                  recevierId: reciverId,
                                  recevierName: username,
                                  recevierImage: userImg);

                              messsageController.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
