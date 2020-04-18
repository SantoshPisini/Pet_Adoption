import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class RoundButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final double width;
  final double height;

  const RoundButtonWidget(
      {@required this.text,
      @required this.onTap,
      @required this.width,
      @required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: width,
        height: height,
        child: RaisedButton(
          elevation: 8,
          textColor: Colors.white,
          color: ThemeData.light().accentColor,
          child: Text(
            text,
            style: TextStyle(fontSize: 16, letterSpacing: 1),
          ),
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
