import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:log_tracker/Models/tracks.dart';
import 'package:log_tracker/Utilities/screen_utils.dart';
import 'package:log_tracker/main.dart';

class CheckedTracksScreen extends StatefulWidget {
  const CheckedTracksScreen({Key? key}) : super(key: key);

  @override
  State<CheckedTracksScreen> createState() => _CheckedTracksScreenState();
}

class _CheckedTracksScreenState extends State<CheckedTracksScreen> {

  @override
  void initState() {
    getDbData();
    // TODO: implement initState
    super.initState();
  }

  void getDbData() async
  {
    List<Map> trackTemp;
    if(accountType == "admin")
      {
        trackTemp = await db.rawQuery('SELECT * FROM LOGS');
      }
    else
      {
        trackTemp = await db.rawQuery('SELECT * FROM LOGS WHERE user_id="${accountUserName}"');
      }
    tracks = [];
    for (int i = 0; i < trackTemp.length; i++) {
      tracks.add(Tracks(
          userName: trackTemp[i]["user_id"].toString()??"",
          machineImage: trackTemp[i]["machine_image"].toString()??"",
          selfieImage: trackTemp[i]["selfie_image"].toString()??"",
          logData: trackTemp[i]["log_data"].toString()??"",
          captureDate: trackTemp[i]["date"].toString()??""
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checked Tracks"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context,index){
                return tracks.isNotEmpty ?
                checkedDataWidget(
                    base64Decode(tracks[index].machineImage),
                    base64Decode(tracks[index].selfieImage),
                    tracks[index].logData,
                    tracks[index].captureDate)
                    :
                Container();
              },
              itemCount: tracks!=null && tracks.isNotEmpty ? tracks.length : 0 ,
              shrinkWrap: true,
            ),
            const SizedBox(height: 50,),
            accountType=="admin"?
            MaterialButton(onPressed: (){

            },color: Colors.black,
              minWidth: ScreenUtils.screenWidth(context)*0.6,
              child: const Text("Download Report",style: TextStyle(color: Colors.white),),)
                :
            Container()
          ],
        ),
      ),
    );
  }

  Widget checkedDataWidget(Uint8List machine_image, Uint8List selfie_image, String logData, String date)
  {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ScreenUtils.screenWidth(context)*0.4,
                child: const Center(child: Text("Machine Image",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),),
              const SizedBox(width: 20,),
              accountType=="admin" ?
              SizedBox(
                width: ScreenUtils.screenWidth(context)*0.4,
                child: const Center(child: Text("Selfie Image",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold))),) : Container(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(machine_image,height:ScreenUtils.screenHeight(context)*0.4 ,width: ScreenUtils.screenWidth(context)*0.4,),
              const SizedBox(width: 20,),
              accountType=="admin" ? Image.memory(selfie_image,height:ScreenUtils.screenHeight(context)*0.4 ,width: ScreenUtils.screenWidth(context)*0.4,) : Container(),
            ],
          ),
          Text("${logData+" \nDate : "+date}",style: TextStyle(fontSize: 15),),
          const SizedBox(height: 15,),
          Container(height: 1,width: ScreenUtils.screenWidth(context)*0.95,color: Colors.black,)
        ],
      ),
    );
  }
}
