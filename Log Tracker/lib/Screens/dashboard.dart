import 'package:flutter/material.dart';
import 'package:log_tracker/Screens/scan_qr.dart';
import 'package:log_tracker/Utilities/screen_utils.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              InkWell(
                child: Text("Logout",style: TextStyle(fontSize: 15),),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : [
              const SizedBox(height: 120,),
              Ink(
                height: ScreenUtils.screenHeight(context)*0.2,
                width: ScreenUtils.screenWidth(context)*0.5,
                child: InkWell(
                  child: Image.asset("assets/icons/scanqr.png",),
                onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>
                    const ScanQrScreen()
                    ));
                },),
              ),
              const SizedBox(height: 80,),
              Ink(
                height: ScreenUtils.screenHeight(context)*0.2,
                width: ScreenUtils.screenWidth(context)*0.5,
                child: InkWell(
                  child: Image.asset("assets/icons/checked_tracks.png"),
                  onTap: (){
                    // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>))
                  },
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget cameraDialogBox(BuildContext buildContext)
  {
    return AlertDialog(
      title: const Text("Upload File!"),
      content: Column(
        children: [
          Ink(
            child: InkWell(
              onTap: (){
              },
              child: const Text("Take Photo"),
            ),
          ),
          Ink(
            child: InkWell(
              onTap: (){
                Navigator.pop(buildContext);
              },
              child: const Text("Cancel"),
            ),
          )
        ],
      ),
    );
  }

}
