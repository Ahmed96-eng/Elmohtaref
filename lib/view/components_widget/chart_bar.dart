// import 'package:flutter/material.dart';
// import 'package:mohtaref_client/constant.dart';
// import 'package:get/get.dart';

// class ChartBar extends StatelessWidget {
//   final String? label;
//   final double? spendingAmount;
//   final double? spendingPctOfTotal;
//   final double? width;
//   final double? height;

//   ChartBar(
//       {this.label,
//       this.spendingAmount,
//       this.spendingPctOfTotal,
//       this.width,
//       this.height});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         // FittedBox(
//         //   child: Text('${spendingAmount!.toStringAsFixed(0)}' + 'sar'.tr),
//         // ),
//         SizedBox(
//           height: height! * 0.01,
//         ),
//         InkWell(
//           onTap: () {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 content: FittedBox(
//                   child:
//                       Text('${spendingAmount!.toStringAsFixed(0)}' + 'sar'.tr),
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             height: height! * 0.2,
//             width: width! * 0.05,
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey, width: 1.0),
//                     color: Color.fromRGBO(220, 220, 220, 1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 FractionallySizedBox(
//                   heightFactor: spendingPctOfTotal,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: redColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: height! * 0.01,
//         ),
//         Text(label!),
//       ],
//     );
//   }
// }
