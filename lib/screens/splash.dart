import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    checkSession();
    super.initState();
  }


  //Checking the Session and moving to respected screens
  void checkSession()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    if(prefs.getString("token")!=null){
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context, true);
        Navigator.pushNamed(context, "/home");
      });
    }else{
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context, true);
        Navigator.pushNamed(context, "/login");
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Stack(
        children: <Widget>[
          Center(
            child:Text('Infinity \n Shop',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontSize: 55,
              fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    );
  }
}
