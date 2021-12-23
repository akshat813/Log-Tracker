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
    accountUserName=prefs.getString(USERNAME).toString();

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
          title: const Center(child: Text("Home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width:20,),
                    InkWell(
                      onTap: () async{
                        accountType="";
                        accountUserName="";
                        prefs = await SharedPreferences.getInstance();
                        prefs.setString(USERNAME,"");
                        prefs.setString(PASSWORD,"");
                        prefs.setString(ACCOUNT_TYPE,"");
                        prefs.setBool(LOGGED_IN, false);
                        loggedIn = false;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen()), (route) => false);
                      },
                      child: const Text("Logout",style: TextStyle(fontSize: 15),),
                    ),
                  ],
                ),
              ],
            )
          ],
          leading: Container(),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
                const SizedBox(height: 120,),
                accountType!="" && accountType!="admin"?
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
                const SizedBox(height: 100,),
                accountType!="" && accountType=="admin"?
                MaterialButton(
                  minWidth: ScreenUtils.screenWidth(context)*0.7,
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterUserScreen()));
                  },
                  color: Colors.black,
                  child: const Text("Add New User",style: TextStyle(fontSize: 18,color: Colors.white),)
                )
                    :
                Container(),
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
      content: Container(
        height: ScreenUtils.screenHeight(buildContext)*0.1,
        width: ScreenUtils.screenWidth(buildContext)*0.6,
        child: Column(
          children: [
            Ink(
              height: ScreenUtils.screenHeight(buildContext)*0.03,
              width: ScreenUtils.screenWidth(buildContext)*0.4,
              child: InkWell(
                onTap: (){
                  Navigator.push(buildContext,MaterialPageRoute(builder: (context)=>
                  const ScanQrScreen()
                  ));
                },
                child: Center(child: const Text("Take Photo",style: TextStyle(fontSize: 18),)),
              ),
            ),
            const SizedBox(height: 20,),
            Ink(
              height: ScreenUtils.screenHeight(buildContext)*0.04,
              width: ScreenUtils.screenWidth(buildContext)*0.4,
              child: InkWell(
                onTap: (){
                  Navigator.pop(buildContext);
                },
                child: Center(child: const Text("Cancel",style: TextStyle(fontSize: 18))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
