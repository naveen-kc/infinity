import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

  //Storing token for session management
  void putToken(String name) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("token", name);
  }

  //Storing all the cart items in local storage
  void putCart(String items) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("cart", items);
  }

}