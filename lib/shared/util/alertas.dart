import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: Colors.black54,
textColor: Colors.white,
fontSize: 16.0);
}