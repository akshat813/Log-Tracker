import 'package:flutter/material.dart';
import 'package:log_tracker/Screens/dashboard.dart';
import 'package:log_tracker/Utilities/screen_utils.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  TextEditingController userNameCont = TextEditingController();
  TextEditingController designationCont = TextEditingController();
  TextEditingController departmentCont = TextEditingController();
  TextEditingController emailIdCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();
  String radioGroup = 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Tracker"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset("assets/icons/company.png"),
              const SizedBox(height: 10,),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                    hintText: "User Name"
                ),
                controller: userNameCont,

              ),
              const SizedBox(height: 10,),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                    hintText: "Designation"
                ),
                controller: designationCont,
              ),
              const SizedBox(height: 10,),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                    hintText: "Department"
                ),
                controller: departmentCont,

              ),
              const SizedBox(height: 10,),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                    hintText: "Email"
                ),
                controller: emailIdCont,
              ),
              const SizedBox(height: 10,),
              const Center(
                child: Text("User type",style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text("Admin"),
                        Radio(
                          value: 'Admin',
                          groupValue: radioGroup,
                          onChanged: (value){
                            radioGroup = value.toString();
                            setState(() {
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("User"),
                        Radio(
                          value: 'User',
                          groupValue: radioGroup,
                          onChanged: (value){
                            radioGroup = value.toString();
                            setState(() {
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
              const SizedBox(height: 10,),
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.black
                        )
                    ),
                    hintText: "Confirm Password"
                ),
                controller: confirmPassCont,
              ),
              const SizedBox(height: 30,),
              Container(
                width: ScreenUtils.screenWidth(context)*0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const Dashboard()));
                },
                    elevation: 0,
                    color: Colors.black,
                    child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
