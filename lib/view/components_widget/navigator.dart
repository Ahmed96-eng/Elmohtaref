import 'package:flutter/material.dart';

goTo(context, Widget screenWidget) {
  Navigator.push(context, createRoute(screenWidget));
}

goToAndFinish(context, Widget screenWidget) {
  Navigator.pushReplacement(context, createRoute(screenWidget));
}

back(context) {
  Navigator.pop(context);
}

Route createRoute(Widget screenWidget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screenWidget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.5);
      const end = Offset.zero;
      const curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
