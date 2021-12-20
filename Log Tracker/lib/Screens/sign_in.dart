import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:log_tracker/Screens/register_user.dart';
import 'package:log_tracker/Utilities/screen_utils.dart';
import 'package:log_tracker/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController userIdCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCameras();
    dbConnection();
  }

  void getCameras() async
  {
    cameras = await availableCameras();
  }

  void dbConnection() async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "my_db.db");
    try {
      db = await openDatabase(path);
      print("DB OPENED ${db}");
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Tracker"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset("assets/icons/company.png"),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                    hintText: "User Id"
                ),
                controller: userIdCont,

              ),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                  hintText: "Password"
                ),
                controller: passCont,
              ),
              const SizedBox(height : 20),
              Container(
                width: ScreenUtils.screenWidth(context)*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(
                    onPressed: (){
                  String id = userIdCont.text.trim();
                  String pass = passCont.text.trim();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterUserScreen()));
                  },
                    elevation: 0,
                    color: Colors.black,
                    child: const Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 18),)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
