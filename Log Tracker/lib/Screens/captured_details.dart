import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturedDetailsScreen extends StatelessWidget {
  XFile file;
  XFile selfie;
  String data;
  CapturedDetailsScreen({Key? key,required this.file,required this.selfie,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.popUntil(context, (route) => false);
          },
            icon:const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.black,
        title: const Text("Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          Row(
            children: [
              Center(child: Image.file(File(file!.path))),
              Center(child: Image.file(File(selfie!.path))),
            ],
          ),
          const SizedBox(height: 40,),
          Center(
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Text("$data",style:const TextStyle(fontSize: 18))),
          )
        ],
      ),
    );
  }
}
