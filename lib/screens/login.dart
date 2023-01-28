import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinity/controllers/loginController.dart';
import 'package:infinity/helpers/dialog_box.dart';
import 'package:infinity/helpers/localStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passController=TextEditingController();
  bool loading=false;

  //Login button integration and storing token for session management
  void login()async{
    setState(()=>loading=true);
    var data= await LoginController().login(nameController.text, passController.text);
        if(data is String){
          setState(()=>loading=false);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AppDialog(
                  header: "Login Fail",
                  description: data,

                );
              });
        }else{
          setState(()=>loading=false);
          LocalStorage local=LocalStorage();
          local.putToken(data['token'].toString());

          Navigator.pop(context,true);
          Navigator.pushNamed(context, '/home');
        }
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child:loading?Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child:
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Colors.green),
                    strokeWidth: 5.0))): Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.visibility_off),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: (){
                      if(nameController.text.isEmpty||passController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                            content: Text(
                                'Please enter both the fields')));
                      }else{
                        login();
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.black,width: 0.5),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: Text('Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

