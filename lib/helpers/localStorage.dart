import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  void putToken(String name) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("token", name);
  }
  void putCart(String items) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("cart", items);
  }

}