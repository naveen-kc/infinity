import 'dart:developer';
https://www.cangra.com/?cnd=3ftp63122ieygip6264874
import 'package:flutter/cupertino.dart';


/*Here I used "Provider" library for State Management because in Provider, widgets listen
to changes in the state and update as soon as they are notified.
Therefore, instead of the entire widget tree rebuilding when there is a state change,
only the affected widget is changed, thus reducing the amount of work and making the app
run faster and more smoothly.*/


class ItemData extends ChangeNotifier
{

  Map selectedItem= {};
  int limit=8;

  //To get selected item
  Map getItem(){
   return selectedItem;
  }

//Notifying the listeners that user pressed the item
  addItem(Map item){
    selectedItem.addAll(item);
    notifyListeners();
  }

//Get the limit on every time scrolls down in home
  String getLimit(){
    return limit.toString();
  }

//Increase the limit by 4
   increaseLimit(){
    limit=limit+4;
    notifyListeners();
  }


}
