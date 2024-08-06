https://teams.microsoft.com/l/meetup-join/19%3ameeting_M2I1NjFhN2ItNDcwOC00MDYyLTgzZjEtMTYxYWY1MDdjMGU0%40thread.v2/0?context=%7b%22Tid%22%3a%225ddc331c-86bd-4762-87d4-a9311b9b6f7c%22%2c%22Oid%22%3a%2288e7348d-5108-446e-acf9-502668a6f9d5%22%7d
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NjY0NGEyNTMtYmZmNi00YjA4LTg2MjItMDEzNzdkOWNiZTI5%40thread.v2/0?context=%7b%22Tid%22%3a%225ddc331c-86bd-4762-87d4-a9311b9b6f7c%22%2c%22Oid%22%3a%2288e7348d-5108-446e-acf9-502668a6f9d5%22%7d
import 'package:flutter/material.dart';
import 'package:infinity/screens/cart.dart';
import 'package:infinity/screens/details.dart';
import 'package:infinity/screens/home.dart';
import 'package:infinity/screens/splash.dart';
import 'package:infinity/screens/login.dart';
import 'package:provider/provider.dart';

import 'controllers/itemData.dart';

void main() {

  runApp(ChangeNotifierProvider<ItemData>(
    child: const MyApp(),
    create: (_) => ItemData(), // Create a new ChangeNotifier object
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  //Setting the navigation screens
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
        '/login':(context)=>Login()
      },
    );
  }
}
