import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bottomnav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString('token');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "its my app",
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.black,
    ),
    home: Scaffold(
      body: MyBottomBarDemo(),
    ),
  ));
}
