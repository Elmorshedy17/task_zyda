import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastTemplate {
  show(String message, {Color color = Colors.black}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: color.withOpacity(0.6),
      // backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
