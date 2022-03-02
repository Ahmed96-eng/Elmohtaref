// import 'package:flutter/material.dart';

// import '../../constant.dart';

// class Badge extends StatelessWidget {
//   const Badge({
//     @required this.child,
//     @required this.value,
//     this.color,
//   });

//   final Widget? child;
//   final String? value;
//   final Color? color;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         child!,
//         Positioned(
//           left: 0,
//           bottom: 0,
//           child: Container(
//             padding: EdgeInsets.all(3.0),
//             // color: Theme.of(context).accentColor,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: color != null ? color : redColor,
//             ),
//             constraints: BoxConstraints(
//               minWidth: 20,
//               minHeight: 20,
//             ),
//             child: Text(
//               value!,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 11, color: mainColor),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
