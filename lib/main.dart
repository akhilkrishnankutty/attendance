import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giiiii/home1.dart';
import 'package:giiiii/intro.dart';
import 'package:giiiii/screens/facwel.dart';
import 'package:giiiii/screens/realtime.dart';
import 'package:giiiii/screens/welcome2.dart';
import 'home.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: 
    // Facwel(userEmail: "fac@ncerc.com",),
    //MyStatefulWidget(userEmail: "akhil@gmail.com",)
    //MyStatefulWidget ()
     Intro()
    // routes: <String,WidgetBuilder>{

    // },
  ));
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}