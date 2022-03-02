import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/home/bottom_nav_bar_layout.dart';

class CancelTaskScreen extends StatefulWidget {
  final String? taskid;

  const CancelTaskScreen({this.taskid});
  @override
  _CancelTaskScreenState createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final noteController = TextEditingController();
  List<CheckBoxListTileModel> checkBoxListTileList = [
    CheckBoxListTileModel(
      title: "reason1".tr,
      value: false,
      groupValue: "0",
    ),
    CheckBoxListTileModel(
      title: "reason2".tr,
      value: false,
      groupValue: "0",
    ),
    CheckBoxListTileModel(
      title: "reason3".tr,
      value: false,
      groupValue: "0",
    ),
    CheckBoxListTileModel(
      title: "reason4".tr,
      value: false,
      groupValue: "0",
    ),
    CheckBoxListTileModel(
      title: "reason5".tr,
      value: false,
      groupValue: "0",
    ),
    CheckBoxListTileModel(
      title: "reason6".tr,
      value: false,
      groupValue: "0",
    ),
  ];
  List<String> radioListTileValue = [];
  String reason = "";
  Color? valueColor;
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("cancel_task".tr),
                centerTitle: true,
                backgroundColor: mainColor,
                leadingWidth: 0.0,
              ),
              body: Container(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: checkBoxListTileList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Text(
                                checkBoxListTileList[index].title!,
                                style: labelStyleMinBlack,
                              ),
                            ),
                            Checkbox(
                              value: checkBoxListTileList[index].value,
                              activeColor: valueColor,
                              onChanged: (value) {
                                setState(() {
                                  if (value == false) {
                                    checkBoxListTileList[index].value = false;
                                    reason = "";
                                  } else {
                                    checkBoxListTileList[index].value = value;
                                    reason = checkBoxListTileList[index].title!;
                                    for (int i = 0;
                                        i < checkBoxListTileList.length;
                                        i++) {
                                      if (i == index) {
                                        valueColor = redColor;
                                      } else {
                                        valueColor = redColor;
                                        checkBoxListTileList[i].value = false;
                                      }
                                    }
                                  }
                                });

                                print(reason);
                              },
                            ),
                          ],
                        ),
                        // children: [

                        //   ...checkBoxListTileList
                        //       .map((e) =>
                        //               // RadioListTile(
                        //               //       groupValue: e.groupValue, toggleable: false,
                        //               //       // checkColor: mainColor,
                        //               //       activeColor: redColor, selected: true,
                        //               //       controlAffinity:
                        //               //           ListTileControlAffinity.leading,
                        //               //       title: Text(
                        //               //         e.title!,
                        //               //         style: styleBlack,
                        //               //       ),
                        //               //       value: e.title!,
                        //               //       onChanged: (value) {
                        //               //         setState(() {
                        //               //           // if (radioListTileValue.any(
                        //               //           //     (element) => element == e.value)) {
                        //               //           //   print("llllllllllll");
                        //               //           //   print(radioListTileValue.any(
                        //               //           //       (element) => element == e.value));
                        //               //           //   // print(radioListTileValue.length);
                        //               //           //   e.groupValue = "0";

                        //               //           //   // radioListTileValue.remove(e.title);
                        //               //           //   // print(radioListTileValue.length);
                        //               //           // } else {
                        //               //           // print(radioListTileValue.any(
                        //               //           //     (element) => element == e.value));
                        //               //           e.groupValue = value.toString();
                        //               //           reason = e.title!;
                        //               //           print(reason);
                        //               //           // radioListTileValue.add(e.title!);
                        //               //           // }
                        //               //         });
                        //               //         // print(e.value);
                        //               //         // print(e.title);
                        //               //         // print(value);
                        //               //         // print(radioListTileValue);
                        //               //         // print(radioListTileValue.length);
                        //               //       },
                        //               //     ))
                        //               Row(
                        //                 children: [
                        //                   Text(e.title!),
                        //                   Checkbox(
                        //                     value: e.value,
                        //                     activeColor: redColor,
                        //                     onChanged: (value) {
                        //                       setState(() {
                        //                         if (value == false) {
                        //                           e.value = value;
                        //                           reason = "";
                        //                           valueColor = mainColor;
                        //                         } else {
                        //                           e.value = value;
                        //                           reason = e.title!;
                        //                           valueColor = redColor;
                        //                         }
                        //                       });
                        //                       print(e.value);

                        //                       print(reason);
                        //                     },
                        //                   ),
                        //                 ],
                        //               )
                        //           // CheckboxListTile(
                        //           //   value: e.value,
                        //           //   activeColor: valueColor,
                        //           //   controlAffinity:
                        //           //       ListTileControlAffinity.leading,
                        //           //   title: Text(e.title!),
                        //           //   onChanged: (value) {
                        //           //     setState(() {
                        //           //       if (value == false || reason == "") {
                        //           //         e.value = value;
                        //           //         reason = e.title!;
                        //           //       } else {
                        //           //         e.value = value;
                        //           //         reason = e.title!;
                        //           //         valueColor = redColor;
                        //           //       }
                        //           //     });
                        //           //     print(e.value);

                        //           //     print(reason);
                        //           //   },
                        //           // )

                        //           //  CheckBoxListTileWidget(
                        //           //   checkBoxListTileModel: e,
                        //           // onChanged: (value) {
                        //           //   setState(() {
                        //           //     e.value = value;
                        //           //   });
                        //           //   print(e.value);
                        //           //   print(e.title);
                        //           //   print(value);
                        //           // },
                        //           // ),
                        //           // )
                        //           )
                        //       .toList(),
                        // ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.01),
                      child: Text(
                        "extra_note".tr,
                        style: thirdLineStyle,
                      ),
                    ),
                    FixedTextField(
                      width: width,
                      height: height * 0.1,
                      enabled: true,
                      hint: "note".tr,
                      icon: Icons.note_alt_rounded,
                      iconColor: redColor,
                      isBold: false,
                      isSearch: false,
                      textInputAction: TextInputAction.done,
                      controller: noteController,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    // Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Center(
                        child: CommonButton(
                            text: "done".tr,
                            width: width * 0.85,
                            containerColor: redColor,
                            textColor: mainColor,
                            onTap: (state is CancelReasonLoadingState)
                                ? () {
                                    showFlutterToast(
                                        message: "loading".tr,
                                        backgroundColor: darkColor);
                                  }
                                : () {
                                    print(radioListTileValue);
                                    cubit.changeCancelTaskExpand(context);
                                    // cubit.changeGoExpand(context);
                                    radioListTileValue.clear();
                                    // goToAndFinish(context, HomeScreen());
                                    print(reason);
                                    if (reason != "")
                                      AppCubit.get(context)
                                          .cancelReason(
                                              taskId: widget.taskid!,
                                              reason: reason,
                                              note: noteController.text)
                                          .then((value) {
                                        goToAndFinish(
                                            context, BotomNavBarLayout());
                                        reason = "";
                                        noteController.clear();
                                      });
                                  }),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}

class CheckBoxListTileModel {
  final String? title;
  bool? value;
  String? groupValue;

  CheckBoxListTileModel({this.title, this.value, this.groupValue});
}

// class CheckBoxListTileWidget extends StatelessWidget {
//   CheckBoxListTileModel? checkBoxListTileModel;
//   // final bool? value;
//   final ValueChanged<dynamic>? onChanged;

//   CheckBoxListTileWidget({
//     this.checkBoxListTileModel,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return RadioListTile(
//       groupValue: 0,
//       // checkColor: mainColor,
//       activeColor: redColor,
//       controlAffinity: ListTileControlAffinity.leading,
//       title: Text(
//         checkBoxListTileModel!.title!,
//         style: styleBlack,
//       ),
//       value: checkBoxListTileModel!.value!,
//       onChanged: onChanged,
//     );
//   }
// }
