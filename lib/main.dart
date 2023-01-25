import 'package:flutter/material.dart';
import 'package:infinity/screens/cart.dart';
import 'package:infinity/screens/details.dart';
import 'package:infinity/screens/home.dart';
import 'package:infinity/screens/splash.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        '/home': (context) => Home(),
        '/cart': (context) => Cart(),
        '/details': (context) => Details(),


      },
    );
  }
}