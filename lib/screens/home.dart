import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinity/controllers/homeController.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../controllers/itemData.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List prods = [];
  List searched=[];
  TextEditingController searchController = TextEditingController();
  bool loading=false;
  FocusNode _focus = FocusNode();
  List catList = [];
  bool selected = false;
  bool showCat=false;
  String selectedCat='';
  bool loader=false;

  @override
  void initState() {
    getProducts();
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  //To get the user action on textfield and also changing ui based on the requirement
  void _onFocusChange() async{
  debugPrint("Focus: ${_focus.hasFocus.toString()}");
  if(_focus.hasFocus){
    var data = await Controller().getCategories();
    setState(() {
      catList=data;
      showCat=true;
    });
  }else{
    setState(() {
      showCat=false;
    });
  }
}

//To get the products by category
void getProductsByCategory(String cat)async{
  setState(() {
    loading=true;
  });
  var data = await Controller().getByType(cat);
  setState(() {
    prods = data;
  });

  setState(() {
    loading=false;
  });
}


//To get the products
  void getProducts() async {
    setState(() {
      loading=true;
    });
    var data = await Controller().getProducts(context);

    setState(() {
      prods = data;
      searched=data;
    });

    setState(() {
      loading=false;
    });
  }

//To get more products when scrolled down
  void loadMore(BuildContext context)async{
    var itemInfo = Provider.of<ItemData>(context,listen: false);
    itemInfo.increaseLimit();
    setState(() {
      loader=true;
    });
    var data = await Controller().getProducts(context);

    setState(() {
      prods = data;
      searched=data;
    });

    setState(() {
      loader=false;
    });
  }


  //To filter the items based on the entered key in textfield
  void filterSearchResults(String query) {
      List results = [];
      if (query.isEmpty) {

        results = searched;
      } else {
        results = prods
            .where((user) =>
            user["title"].toLowerCase().contains(query.toLowerCase()))
            .toList();

      }

      // Refresh the UI
      setState(() {
        prods = results;
      });
    }


  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemInfo = Provider.of<ItemData>(context,listen: false);
    //final myList = context.watch<ItemData>().selectedItem;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Center(child:
            TextButton(
                style:  TextButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shadowColor: Colors.grey,
                  elevation: 3,
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
            ),SizedBox(width: 15,)],
          title:SizedBox(
            height: 40,
            child: TextField(
              focusNode: _focus,
              onChanged: (value){
                filterSearchResults(value);
              },
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    fillColor: Colors.white,
                      filled: true,
                      hintText: "Search",
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          showCat=false;
                          prods=searched;
                          selectedCat='';
                          searchController.text='';

                        });
                        _focus.unfocus();
                        
                      }, icon: Icon(Icons.cancel_outlined),
                        
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
          ),


        ),
        body:loading?Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child:
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Colors.green),
                    strokeWidth: 5.0))):
              Column(
                children: [
                  if(showCat)
                    Wrap(
                      spacing: 8,
                      direction: Axis.horizontal,
                      children: [
                        for (int i=0; i< catList.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(left:10, right: 5),
                            child: FilterChip(
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: selectedCat.trim()==catList[i]?Colors.greenAccent:Colors.grey,
                              padding: const EdgeInsets.all(8.0),
                              label: Text(
                                catList[i],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  height: 1.4,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ), onSelected: (value) {
                                setState(() {
                                  selectedCat=catList[i];
                                });
                                getProductsByCategory(selectedCat);
                            },
                            ),
                          )
                      ],
                    ),

                  Expanded(
                    child: LazyLoadScrollView(
                       isLoading: loader,
                        onEndOfPage: () => loadMore(context),
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                            itemCount: prods.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      itemInfo.addItem(prods[index]);
                                     // myList.addAll(prods[index]);
                                      Navigator.pushNamed(context, "/details",/*arguments: {'prod':prods[index]}*/);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey,width: 0.5),
                                        borderRadius: BorderRadius.circular(10)
                                      ),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 5,),
                                           Image.network(prods[index]['image'],
                                              height: 80,),
                                         Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child:  Text(prods[index]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14
                                              ),),
                                           ),

                                          Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                                                child: Row(
                                                  children: [
                                                    Text(prods[index]['rating']['rate'].toString(),
                                                      textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14
                                                        )),
                                                    Spacer(),
                                                    Text('₹ '+prods[index]['price'].toString(),
                                                      textAlign: TextAlign.center,style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14
                                                      ),),
                                                  ],
                                                ),
                                              ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              );
                            }),
                      )),
                  ),
                  if(loader)
                    SizedBox(
                      height: 60,
                      child: Center(
                          child: SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child:
                              CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.green),
                                  strokeWidth: 2.0))),
                    )

                ],
              ),
         );
  }
}




