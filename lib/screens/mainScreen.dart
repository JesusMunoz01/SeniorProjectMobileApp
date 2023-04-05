import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_grocery_application/screens/itemsScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:sp_grocery_application/screens/settingsScreen.dart';
import 'package:sp_grocery_application/utils/API.dart';
import 'package:sp_grocery_application/config/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/itemDatabase.dart';
import 'package:sp_grocery_application/utils/userDatabase.dart';

class MainScreen extends StatefulWidget {
  String user;
  MainScreen(this.user);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  int qty = 0;
  Future<String> futureP;
  Future<dynamic> futureI;
  Future<dynamic> futureU;
  String money;
  int itemNum = 0;
  bool update = true;
  String id = "701111";
  bool fav = false;
  @override
  void initState() {
    super.initState();
    //futureP = GroceryAPI.fetchPrice(httpClient, id);
    futureI = databaseSingle();
    futureU = databaseSingleFav();
  }

  databaseSingle() async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('items/itemList').get();
    if (snapshot.exists){
      return(snapshot.value);
    }
  }

  databaseSingleFav() async{
  final ref1 = FirebaseDatabase.instance.ref();
  final snapshot1 = await ref1.child('profiles/${widget.user}/items').get();
    if (snapshot1.exists){
      return(snapshot1.value);
    }
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference newMyRef = FirebaseDatabase.instance.ref("items/itemList");
  ItemDatabase testItem;
  List<ItemDatabase> testItems = getItem();
  static double price;
  List<dynamic> itemList;


  @override
  Widget build(BuildContext context) {
  // List containing two screens (Home and Items)

  List<Widget> _widgets = <Widget>[
    //--------------Main Screen Section (Home tab)--------------
    FutureBuilder<dynamic>(
      future: futureU,
      initialData: null,
      builder: (context, newSnapshot) {
      if (newSnapshot.hasData && newSnapshot.connectionState == ConnectionState.done) {
        Map map = newSnapshot.data;
                return ListView( children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        "User Budget\n" + "\$${500}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                        key: Key("budgetText"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Text(
                        "Favorites",
                        style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                        key: Key("favoriteText"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    for(var r in map.values)
                      if(r["isFav"] == true)
                      ListTile(
                        title: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                            // if(update == true && itemNum < 5)
                            //   FutureBuilder<String>(
                            //     future: GroceryAPI.fetchPrice(httpClient, r["id"]),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData && itemNum < 2) {
                            //         DatabaseReference setAPIPrice = FirebaseDatabase.instance.ref("items/itemList/${itemNum}");
                            //         setAPIPrice.update({"price": double.parse(snapshot.data)});
                            //         itemNum++;
                            //         update = false;
                            //        } else if (snapshot.hasError) {
                            //          return Text('${snapshot.error}');
                            //        }
                            //        return CircularProgressIndicator();
                            //      },
                            //    ),
                              Text(r["item"], textScaleFactor: 0.75,),
                              Spacer(),
                              Text("\$" + r["price"].toString() + "\t", textScaleFactor: 0.85,),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () {
                                    setState(() {
                                      qty--;
                                    });
                                  },
                                  child: Text(
                                    "-",
                                    textScaleFactor: 1,
                                  )),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "QTY:",
                                      textScaleFactor: 0.75,
                                    ),
                                    Text(
                                      "${qty}",
                                      textScaleFactor: 0.75,
                                    )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });
                                  },
                                  child: Text("+"))
                            ])),
                        //onTap: () {},
                      ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: Size(100, 50)),
                        key: Key("mainScreenButton"),
                        onPressed: () {},
                        child: Text(
                          "Test",
                          key: Key("buttonText"),
                        ),
                      ),
                    ),
                  ],
                )]);
      }
      return CircularProgressIndicator();}),
                // ---------End of Main Screen section (Home Tab)-----------

                // -----------Items Screen Section (Items tab)---------------
                FutureBuilder<dynamic>(
                  future: futureI,
                  initialData: null,
                  builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    //itemList = snapshot.data;
                    //List<dynamic> set = itemList.map((itemList) => itemList['item'] as dynamic).toList();
                    List<dynamic> set = snapshot.data as List<dynamic>;
                return ListView( children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        "Items",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                        key: Key("itemsMainText"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    for(var r in set)
                      ListTile(
                        title: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                            // if(update == true && itemNum < 2)
                            //   FutureBuilder<String>(
                            //     future: GroceryAPI.fetchPrice(httpClient, r["id"]),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData && itemNum < 2) {
                            //         DatabaseReference setAPIPrice = FirebaseDatabase.instance.ref("items/itemList/${itemNum}");
                            //         setAPIPrice.update({"price": double.parse(snapshot.data)});
                            //         itemNum++;
                            //         update = false;
                            //        } else if (snapshot.hasError) {
                            //          return Text('${snapshot.error}');
                            //        }
                            //        return CircularProgressIndicator();
                            //      },
                            //    ),
                              
                              IconButton(onPressed: () async{
                                setState((){
                                  fav = !fav;
                                  
                              });
                                if(fav == true){
                                    final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}/items/${r["id"]}");
                                    await snapshot.update({"isFav": true, "item":r["item"], "id":r["id"], "price":r["price"]});
                                }else{
                                  final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}/items/${r["id"]}");
                                    await snapshot.update({"isFav": false, "item":r["item"], "id":r["id"], "price":r["price"]});
                                };
                              ;}, 
                              icon: fav ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
                              Text(r["item"], textScaleFactor: 0.75,),
                              Spacer(),
                              Text("\$" + r["price"].toString() + "\t", textScaleFactor: 0.85,),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async {},
                                  child: Text(
                                    "-",
                                    textScaleFactor: 1,
                                  )),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "QTY:",
                                      textScaleFactor: 0.75,
                                    ),
                                    Text(
                                      "0",
                                      textScaleFactor: 0.75,
                                    )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async{ },
                                  child: Text("+"))
                            ])),
                        //onTap: () {},
                      ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: ElevatedButton(
                        key: Key("itemsScreenButton"),
                        onPressed: () {},
                        child: Text(
                          "Add",
                          key: Key("itemsButtonText"),
                        ),
                      ),
                    ),
                  ],
               )]);
              }return CircularProgressIndicator();}), 
                //------------End of Items Screen section (Items Tab)------------
              ];

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CustomSearch());
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                icon: Icon(Icons.settings)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag))
          ],
        ),
        body:Center(child: _widgets.elementAt(_index)),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_rounded),
              label: 'Items',
            ),
          ],
          key: Key('tabs'),
          currentIndex: _index,
          onTap: (int value) {
            setState(() {
              _index = value;
            });
          },
        ));
  }
}

  databaseSingle() async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('items/itemList').get();
    if (snapshot.exists){
      return(snapshot.value);
    }
  }
  Future<dynamic> searchRef = databaseSingle();

class CustomSearch extends SearchDelegate {
  List<ItemDatabase> items = getItem();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSearch(context: context, delegate: CustomSearch());
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.backspace));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: searchRef,
      builder: (context, snapshot) {
        if(snapshot.hasData){
    List<dynamic> sets = snapshot.data as List<dynamic>;
    List<String> match = [];
    var result;
    int counter = 0;
    var item;
    int length = 0;
    for (var item in sets) {
      if (item['item'].toLowerCase().contains(query.toLowerCase())) {
        match.add(item['item']);
        length++;
      }
    }
    return ListView.builder(
        itemCount: length,
        itemBuilder: (context, int index) {
          result = match[index];
          item = sets[index];
          int counter = 0;
          for (var i in sets) {
            if (i['item'].toLowerCase().contains(match[index].toLowerCase())) {
              item = sets[counter];
            }
            counter++;
          }
          return new ListTile(
            title: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text(item['item']),
                  Spacer(),
                  Text("\$" + item['price'].toString() + "\t"),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(20, 20)),
                      onPressed: () {},
                      child: Text(
                        "-",
                        textScaleFactor: 1,
                      )),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "QTY:",
                          textScaleFactor: 0.75,
                        ),
                        Text(
                          "1",
                          textScaleFactor: 0.75,
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(20, 20)),
                      onPressed: () {},
                      child: Text("+"))
                ])),
            //onTap: () {},
          );
        });
        }return CircularProgressIndicator();});
  }
  

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: searchRef,
      builder: (context, snapshot) {
        if(snapshot.hasData){
      List<dynamic> sets = snapshot.data as List<dynamic>;
      List<String> match = [];
      String result;
      int length = 0;
      for (var item in sets) {
        if (item["item"].toLowerCase().contains(query.toLowerCase())) {
          match.add(item["item"]);
          length++;
        }
      }
      return ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          result = match[index];
          return new GestureDetector(
            onTap: () {
              query = match[index];
              showResults(context);
            },
            child: ListTile(title: Text("${result}")),
          );
        },
      );
  } return CircularProgressIndicator();});
  }
}

/* ----------- Obtain Items in Database -----------------
  Future<dynamic> futureP;

  void initState() {
    super.initState();
    futureP = databaseSingle();
  }

  databaseSingle() async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('items/itemList').get();
    if (snapshot.exists){
      return(snapshot.value);
    }
  }

  // This goes inside a Widget, builds text & other functions
  FutureBuilder<dynamic>(
    future: futureP,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text('${snapshot.data}');
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return CircularProgressIndicator();
      },
  ),
  ----------------------------------------------*/

  /*  ------------Database Push----------
  // Replaces whats currently in database
                onPressed: () async {
                await newMyRef.set({
                  "item": testItem.name,
                  "id": testItem.id,
                   "price": testItem.price
                });
              },

  // Makes a new child and replaces whats inside
    onPressed: () async {
      await newMyRef.child(_username.text); // Makes child with given value (username.text)

      // Searches for the new ref (child) and inserts text
      DatabaseReference myNewRef = FirebaseDatabase.instance.ref("profiles/${_username.text}");
      await myNewRef.set({"username": _username.text,"password": _password.text,});
  ----------------------------------------------*/

  /* -------------API-----------
            FutureBuilder<String>(
              future: futureP,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  money = snapshot.data;
                  return Text('${snapshot.data}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            --------------------------------*/

  /*------------Old Body---------
  Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "User Budget\n" + "\$${500}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                  key: Key("budgetText"),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  "Recommended",
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                  key: Key("mainScreenText"),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              for (ItemDatabase item in testItems)
                ListTile(
                  title: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text(item.name),
                        Spacer(),
                        Text("\$" + item.price.toString() + "\t"),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 20)),
                            onPressed: () {},
                            child: Text(
                              "-",
                              textScaleFactor: 1,
                            )),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "QTY:",
                                textScaleFactor: 0.75,
                              ),
                              Text(
                                "1",
                                textScaleFactor: 0.75,
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 20)),
                            onPressed: () {},
                            child: Text("+"))
                      ])),
                  //onTap: () {},
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: ElevatedButton(
                  key: Key("mainScrenButton"),
                  onPressed: () {},
                  child: Text(
                    "Test",
                    key: Key("buttonText"),
                  ),
                ),
              ),
            ],
          ),
          --------------------------------*/