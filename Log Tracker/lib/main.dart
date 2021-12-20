import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:log_tracker/Screens/sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> cameras = [];
var db;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Permission.camera.request();
    Permission.microphone.request();
    return MaterialApp(
      title: 'Log Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
