import 'dart:developer';

import 'package:flutter/cupertino.dart';

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