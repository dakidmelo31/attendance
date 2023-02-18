import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Globals{
  static Color backgroundColor = const Color(0xFFE0FBFC);
  static Color primaryColor = const Color(0xFF002A32);

  static TextStyle blackText = const TextStyle(color: Colors.grey);

  static var greenText = const TextStyle(color: Colors.green);
  static var blackNumberText = const TextStyle(fontSize: 40, color: Colors.black);
  static Future<void> signUp({required String email, required String password, required String phone}) async{

  }
  static Future<void> toast({required String message, Color bgColor = Colors.black, Color textColor = Colors.white, Toast length = Toast.LENGTH_SHORT })async{
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message, backgroundColor: bgColor, toastLength: length, textColor: textColor);
  }

  static Future<void> signIn({required String email, required String password}) async{

  }

  static Size getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }


}