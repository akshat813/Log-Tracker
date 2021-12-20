import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturedDetailsScreen extends StatelessWidget {
  XFile file;
  CapturedDetailsScreen({Key? key,required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          Row(
            children: [

            ],
          )
        ],
      ),
    );
  }
}
