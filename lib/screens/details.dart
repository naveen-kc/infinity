import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinity/helpers/localStorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/itemData.dart';


class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

// Adding item to cart also checking the item is already exist in cart
  void addToCart(Map product)async{
    LocalStorage local= LocalStorage();
    List items=[];

    SharedPreferences prefs= await SharedPreferences.getInstance();
    String? data=prefs.getString('cart');
    if(data==null){
      items.add(product);
      var s = json.encode(items);
      local.putCart(s);
    }
    else if(data!.isNotEmpty){
      var check=json.decode(data);
      items=check;

      for(var i in items){
        if(i['id']==product['id']){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  'This item is already exist in cart')));
          return;
        }

      }

      items.add(product);
      var s = json.encode(items);
      local.putCart(s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
              'Added to cart successfully')));

    }
  }


  @override
  Widget build(BuildContext context) {
    /*final args = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      product = args['prod'];
    });*/

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Details',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(child:
            TextButton(
              style:  TextButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
                onPressed:(){
                  Navigator.pushNamed(context, "/cart");
                },
                child:Text('Cart',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),)),
            ),
          )
        ],
      ),
      body:SafeArea(
      child:Consumer<ItemData>(builder: (context, data,child) {
        return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:   Image.network(data.selectedItem['image']),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(data.selectedItem['title'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            )),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text('₹ '+data.selectedItem['price'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),),

                          Text('Rating: '+data.selectedItem['rating']['rate'].toString()+'/5',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),),
                        ],
                      ),

                    ],
                  ),


                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  child: Text(data.selectedItem['description'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.5
                      )),
                ),
              ],
            )

          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 2,
                    offset: Offset(
                      -1,
                      1,
                    ),
                  )
                ],
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child:   Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 14, color: Colors.white))),
                      onPressed: ()async{
                       addToCart(data.selectedItem);

                      },
                      child: const Text('Add to Cart')),
                ),
              ),

            ),
          )
        ],
      );
      },),
      )
    );
  }
}
