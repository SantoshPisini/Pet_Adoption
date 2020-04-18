import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

const kSalt = "SPAAI@2020";
const kTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
const kHighLightTextStyle = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blueAccent);
//const kButtonStyle = Button;

const kColor_GUNMETAL = Color.fromRGBO(45, 49, 66, 1);
const kColor_LIGHTGRAY = Color.fromRGBO(207, 204, 214, 1);
const kColor_STEELBLUE = Color.fromRGBO(187, 194, 226, 1);
const kColor_BLUEPURPLE = Color.fromRGBO(183, 181, 228, 1);
const kColor_TROLLYGRAY = Color.fromRGBO(132, 121, 121, 1);
