import 'package:flutter/material.dart';
import 'package:log_tracker/Constants/preferences.dart';
import 'package:log_tracker/Screens/register_user.dart';
import 'package:log_tracker/Screens/scan_qr.dart';
import 'package:log_tracker/Screens/sign_in.dart';
import 'package:log_tracker/Utilities/screen_utils.dart';
import 'package:log_tracker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  late SharedPreferences prefs;

  void getPrefValues() async
  {
    prefs = await SharedPreferences.getInstance();
    accountType = prefs.getString(ACCOUNT_TYPE).toString();
  }

  @override
  Widget build(BuildContext context) {
    if(accountType==null || accountType=="")
      {
        getPrefValues();
      }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Home")),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    accountType!="" && accountType=="admin"?
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterUserScreen()));
                      },
                      child: const Text("Add New User",style: TextStyle(fontSize: 15),),
                    )
                    :
                    Container(),
                    const SizedBox(width:20,),
                    InkWell(
                      onTap: (){
                        accountType="";
                        accountUserName="";
                        prefs.setString(USERNAME,"");
                        prefs.setString(PASSWORD,"");
                        prefs.setString(ACCOUNT_TYPE,"");
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen()), (route) => false);
                      },
                      child: const Text("Logout",style: TextStyle(fontSize: 15),),
                    ),
                  ],
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
                accountType!="" && accountType=="admin"?
                Ink(
                  height: ScreenUtils.screenHeight(context)*0.2,
                  width: ScreenUtils.screenWidth(context)*0.5,
                  child: InkWell(
                    child: Image.asset("assets/icons/scanqr.png",),
                  onTap: () async {
                    await showDialog(context: context, builder: (_) => cameraDialogBox(context),
                    );
                  },),
                )
                    :
                Container(),
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
                Navigator.push(buildContext,MaterialPageRoute(builder: (context)=>
                const ScanQrScreen()
                ));
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
