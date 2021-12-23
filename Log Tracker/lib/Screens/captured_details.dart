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
        title: const Text("Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("MACHINE"),
              Text("SELFIE"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.file(File(file!.path),height: 200,width: 200,),
              Image.file(File(selfie!.path),height: 200,width: 150,),
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
