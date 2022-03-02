import 'package:flutter/material.dart';

import '../../constant.dart';

class LoadingProgressIndecator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      ),
    );
  }
}
