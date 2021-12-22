import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturedDetailsScreen extends StatelessWidget {
  XFile file;
  String data;
  CapturedDetailsScreen({Key? key,required this.file,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: Image.file(File(file!.path))),
          Container(
              padding: const EdgeInsets.all(20),
              child: Text("${data}",style:const TextStyle(fontSize: 18)))
        ],
      ),
    );
  }
}
