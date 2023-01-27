import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ItemData extends ChangeNotifier
{

  Map selectedItem= {};

  Map getItem(){
   return selectedItem;
  }


  addItem(Map item){
    selectedItem.addAll(item);
    log(" item ::::"+item.toString());
    notifyListeners();
  }
}