import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinity/helpers/alert_box.dart';
import 'package:infinity/helpers/localStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List cartItems=[];
  double amount=0.0;

  @override
  void initState() {
    // TODO: implement initState
    getCart();
    super.initState();
  }

  void getCart() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.getString('cart');
    log("data ::::"+prefs.getString('cart')!);

    List carts= json.decode( prefs.getString('cart')!);
    setState(() {
      cartItems=carts;
    });

    getTotal();


  }

  void getTotal(){
    amount=0.0;

    for(var i in cartItems){

      double temp=0.0;

      temp =double.parse(i['price'].toString());

      setState(() {
        amount+=temp;
      });

    }

  }


  void remove(String id)async{
    LocalStorage local= LocalStorage();

    setState(() {
      cartItems.removeWhere((element) => element['id'].toString()==id);
    });

    var data= json.encode(cartItems);
   local.putCart(data);
    getTotal();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Your Cart',),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            cartItems.length==0?Center(
              child: Text('No Items in your cart',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,

                ),),
            ):
           Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 60),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.0,
                                  spreadRadius: 1,
                                  offset: Offset(
                                    0.5,
                                    0.5,
                                  ),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                              child: Column(children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        height:70,
                                          width: 60,
                                          child: Image.network(cartItems[index]['image'])),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Text(cartItems[index]['title'],
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis
                                      ),),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 100,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:BoxDecoration(
                                  color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey),
                                  ),
                                        child: Center(child: Text('₹ '+cartItems[index]['price'].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15
                                        ),)),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                header: "Remove item",
                                                description: "Are really want to remove this item from cart?",
                                                okay: () {
                                                  remove(cartItems[index]['id'].toString());

                                                },
                                                yes: 'Remove',
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                        width: 100,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration:BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),child: Center(
                                            child: Text(
                                            'Remove',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15
                                              )
                                        ),
                                          ),),
                                      ),
                                    )
                                  ],),
                                )

                              ]),
                            ),
                          ),
                        );
                      }),

            ),



            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
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
                child:  Row(
                  children: [
                    IconButton(onPressed: (){

                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertBox(
                              header: "Logout",
                              description: "If you logout, all the items in the cart will be deleted. Still want to logout?",
                              okay: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.clear();
                                Navigator.popUntil(context, (route) => route.settings.name == '/splash');
                                Navigator.pushNamed(context, "/login");
                              },
                              yes: 'Logout',
                            );
                          });

                    }, icon: Icon(Icons.logout)),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text(
                          '₹ '+amount.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                  ],
                ),


              ),
            ),

          ],
        ),
      ),
    );
  }
}
