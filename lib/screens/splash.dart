import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context, true);
      Navigator.pushNamed(context, "/home");
    });

    super.initState();
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
