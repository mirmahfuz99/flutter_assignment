import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Const {
  static String user = "user";
  static String isLogin = "isLogin";
  static String TRUE = "true";
  static String FALSE = "false";
  static String cookie = "cookie";



  static showMessage(String message,
      {Color backgroundColor = Colors.red, Color textColor = Colors.white}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0);
  }


  static showLoader(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SpinKitRipple(
            size: 150,
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.red,
                ),
              );
            },
          ),
        );
      },
    );
  }
}