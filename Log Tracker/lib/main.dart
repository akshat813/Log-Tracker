import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:log_tracker/Models/user.dart';
import 'package:log_tracker/Screens/sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> cameras = [];
var db;
String accountType="";
String accountUserName="";
List<Map> userList =[];
List<User> users = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Tracker',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black,titleTextStyle: TextStyle(color: Colors.white)),
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
