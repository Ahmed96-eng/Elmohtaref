// // import 'package:flutter/material.dart';

// // class TextChart extends StatefulWidget {
// //   @override
// //   _TextChartState createState() => _TextChartState();
// // }

// // class _TextChartState extends State<TextChart> {
// //   int _currentPage = 0;

// //   final _controller = PageController(initialPage: 0);
// //   final _duration = Duration(milliseconds: 300);
// //   final _curve = Curves.easeInOutCubic;
// //   final _pages = [
// //     // LineChartPage(),
// //     // BarChartPage(),
// //     // BarChartPage2(),
// //     // PieChartPage(),
// //     // LineChartPage2(),
// //     // LineChartPage3(),
// //     // LineChartPage4(),
// //     // BarChartPage3(),
// //     // ScatterChartPage(),
// //     // RadarChartPage(),
// //   ];

// //   // bool get isDesktopOrWeb => PlatformInfo().isDesktopOS() || PlatformInfo().isWeb();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller.addListener(() {
// //       setState(() {
// //         _currentPage = _controller.page!.round();
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: PageView(
// //           physics: NeverScrollableScrollPhysics(),
// //           controller: _controller,
// //           children: [],
// //         ),
// //       ),
// //       bottomNavigationBar: Container(
// //         padding: EdgeInsets.all(16),
// //         color: Colors.transparent,
// //         child: Row(
// //           mainAxisSize: MainAxisSize.max,
// //           children: [
// //             Visibility(
// //               visible: _currentPage != 0,
// //               child: FloatingActionButton(
// //                 onPressed: () => _controller.previousPage(
// //                     duration: _duration, curve: _curve),
// //                 child: Icon(Icons.chevron_left_rounded),
// //               ),
// //             ),
// //             Spacer(),
// //             Visibility(
// //               visible: _currentPage != _pages.length - 1,
// //               child: FloatingActionButton(
// //                 onPressed: () =>
// //                     _controller.nextPage(duration: _duration, curve: _curve),
// //                 child: Icon(Icons.chevron_right_rounded),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mohtaref_client/view/components_widget/style.dart';

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<DashboardScreen> {
//   final Geolocator geolocator = Geolocator();
//   Position? _currentPosition;
//   String? _currentAddress;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   _getCurrentLocation() {
//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//       print("cccccccccccc" + "$_currentPosition");

//       _getAddressFromLatLng();
//       print("zzzzzzzzzzzz" + "$_currentPosition");
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddressFromLatLng() async {
//     try {
//       print("start");
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           _currentPosition!.latitude, _currentPosition!.longitude);
//       // List<Placemark> placemarks =
//       //     await placemarkFromCoordinates(52.2165157, 6.9437819);
//       Placemark place = placemarks[0];
//       print("start1");
//       print(place.street);
//       print(place.administrativeArea);
//       print(place.subAdministrativeArea);
//       print(place.country);
//       print(place.name);
//       print(place.locality);
//       print(place.subLocality);
//       print(place.isoCountryCode);
//       print(place.postalCode);
//       print(place.subThoroughfare);
//       print(place.thoroughfare);

//       setState(() {
//         _currentAddress =
//             "${place.street},${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
//       });
//       return print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$_currentAddress");
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("DASHBOARD"),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 _getAddressFromLatLng();
//               },
//               child: Text("data"))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).canvasColor,
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Icon(Icons.location_on),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 'Location',
//                                 style: Theme.of(context).textTheme.caption,
//                               ),
//                               if (_currentPosition != null &&
//                                   _currentAddress != null)
//                                 Text(
//                                   _currentAddress!,
//                                   style: thirdLineStyle,
//                                 ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class Placemark{}