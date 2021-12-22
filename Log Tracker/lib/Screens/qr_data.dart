import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:log_tracker/Constants/preferences.dart';
import 'package:log_tracker/Screens/capture_log_data.dart';
import 'package:log_tracker/Utilities/screen_utils.dart';
import 'package:log_tracker/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class QrDataScreen extends StatefulWidget {
  final String? qrData;
  QrDataScreen({Key? key, this.qrData,}) : super(key: key);

  @override
  State<QrDataScreen> createState() => _QrDataScreenState();
}

class _QrDataScreenState extends State<QrDataScreen> {
  String dataInQr="";

  XFile? file;

  CameraController selfieController = CameraController(cameras[1], ResolutionPreset.low);
  XFile? selfieFile;

  @override
  void initState() {
    print("QR DATA ${widget.qrData}");
    // TODO: implement initState
    if(widget.qrData==null)
    {
      getPrefValues();
    }

    super.initState();
  }

  @override
  void dispose() {
    if(selfieController!=null) {
      //selfieController.dispose();
    }
    super.dispose();
  }
  
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  void getPrefValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataInQr = prefs.getString(QRDATA)??"";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("QR Data",style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.qrData!=null || dataInQr!=""?
              SizedBox(
                height: ScreenUtils.screenHeight(context)*0.25,
                child: widget.qrData==null?
                Text("${dataInQr}",style: const TextStyle(fontSize: 15),):
                Text("${widget.qrData}",style: const TextStyle(fontSize: 15),),
              )
                  :
              Container(height: 50,),
              Container(color: Colors.black,height: 1,width: ScreenUtils.screenWidth(context)*0.98,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Container(alignment:Alignment.topLeft,child: const Text("Log Data",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                  file!=null ? Image.file(File(file!.path),height: ScreenUtils.screenHeight(context)*0.5,width: ScreenUtils.screenWidth(context)*0.7,) : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(onPressed: () async {
                        print("CAPTURE LOG CLICK");
                        var status1 = await Permission.camera.status;
                        var status2 = await Permission.microphone.status;
                        if(status1.isGranted && status2.isGranted && (file==null))
                          {
                            file =  await Navigator.push(context, MaterialPageRoute(builder: (context)=>const CameraPage()));
                            setState(() {
                            });
                          }
                        else
                          {
                            if(status1.isGranted && status2.isDenied) {
                              Permission.microphone.request();
                            }
                            else if (status2.isGranted && status1.isDenied)
                            {
                              Permission.camera.request();
                            }
                            else
                              {
                                Fluttertoast.showToast(msg: "Already captured",backgroundColor: Colors.red);
                              }
                          }

                        },
                      color: Colors.black,
                        child: const Text("Capture Log Data",style: TextStyle(color: Colors.white),),
                      ),
                      MaterialButton(
                        minWidth: 70,
                        onPressed: (){
                          if (file!=null)
                            {
                              selfieController != null?
                              onTakePictureButtonPressed()
                                  : null;
                              // if(selfieFile!=null)
                              //   {
                              //     //NAVIGATE TO DETAILS PAGE AND SAVE IN DB
                              //   }
                              // else
                              //   {
                              //     Fluttertoast.showToast(msg: "Try later",backgroundColor: Colors.red);
                              //   }
                            }
                          else
                            {
                              Fluttertoast.showToast(msg: "Capture log first",backgroundColor: Colors.red);
                            }
                        },
                        color: Colors.black,
                        child: const Text("Submit",style: TextStyle(color: Colors.white),),
                      )
                    ],
                  )
                ],
              ),
              selfieFile!=null? Image.file(File(selfieFile!.path)) : Container()
            ],
          ),
        ),
      ),
    );
  }

  void onTakePictureButtonPressed() {
    selfieController.initialize().then((_) {
      print("INITIALISED");
      takePicture().then((XFile? file1) {
        if (mounted) {
          setState(() {
            selfieFile = file1;
          });
          if (file1 != null) {
            print("CAPTURED_SELFIE");

            final logPicBytes = File(file!.path).readAsBytesSync();
            final selfieBytes = File(selfieFile!.path).readAsBytesSync();
            String dateTime = DateTime.now().toString();
            print("date $dateTime");
            insertIntoDb(base64Encode(logPicBytes),base64Encode(selfieBytes),widget.qrData??dataInQr,dateTime);
          }
        }
      });
      setState(() {

      });
    });
    print("IN TAKE PIC");
  }

  Future<XFile?> takePicture() async {
    print("TAKE PIC FUNC");
    final CameraController? cameraController = selfieController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      Fluttertoast.showToast(msg: "Error Camera",backgroundColor: Colors.red);
      print("ERROR CAMERA");
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      print("ALREADY ACTIVE");
      return null;
    }

    try {
      XFile file2 = await cameraController.takePicture();
      print("IN TRY");
      return file2;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    print("EXCEPTION ${e.code}, ${e.description}");
    Fluttertoast.showToast(msg:'Error: ${e.code}\n${e.description}',backgroundColor: Colors.red);
  }

  void insertIntoDb(String log_image, String selfie, String data, String date) async
  {
    //print("Data_to_insert $log_image, $selfie, $data, $date");
    await db.execute("CREATE TABLE IF NOT EXISTS LOGS(id INTEGER PRIMARY KEY, machine_image TEXT, selfie_image TEXT, log_data TEXT, date VARCHAR(20))");
    print("table create -> logs");
    var length = Sqflite
        .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM LOGS'));

    Fluttertoast.showToast(msg: "data inserted in db");
    String selfie="abc";
    String data="cde";
    String date="efg";
    await db.rawInsert("INSERT INTO LOGS VALUES(${length!+1},${log_image},${selfie},${data},${date})");
    print("Record_Inserted_In_Logs_SQLITE");
    //await db.insert("LOGS", {});
  }

}
