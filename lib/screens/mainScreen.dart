import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_grocery_application/screens/itemsScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:sp_grocery_application/screens/settingsScreen.dart';
import 'package:sp_grocery_application/utils/API.dart';
import 'package:sp_grocery_application/config/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/itemDatabase.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  Future<String> futureP;
  String money;
  @override
  void initState() {
    super.initState();
    futureP = GroceryAPI.fetchPrice(httpClient, testItem.id);
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  //DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles");
  DatabaseReference newMyRef = FirebaseDatabase.instance.ref("items").push();
  ItemDatabase testItem = product1();
  List<ItemDatabase> testItems = getItem();
  static double price;

  /*  ------------Database Push--------
                onPressed: () async {
                await newMyRef.set({
                  "item": testItem.name,
                  "id": testItem.id,
                   "price": testItem.price
                });
              },
             ----------------------------------*/

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

  // List containing two screens (Home and Items)
  List<Widget> _widgets = <Widget>[
    //--------------Main Screen Section (Home tab)--------------
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
        for (ItemDatabase item in getItem())
          ListTile(
            title: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  FutureBuilder<String>(
                    future: GroceryAPI.fetchPrice(httpClient, item.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        item.price = double.parse(snapshot.data);
                        price = item.price;
                        item.setPrice(price);
                        return Text("${price}");
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  Text(item.name),
                  Spacer(),
                  Text("\$" + item.price.toString() + "\t"),
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
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: ElevatedButton(
            key: Key("mainScreenButton"),
            onPressed: () {},
            child: Text(
              "Test",
              key: Key("buttonText"),
            ),
          ),
        ),
      ],
    ),
    // ---------End of Main Screen section (Home Tab)-----------

    // -----------Items Screen Section (Items tab)---------------
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
        for (ItemDatabase item in getItem())
          ListTile(
            title: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text(item.name),
                  Spacer(),
                  Text("\$" + item.price.toString() + "\t"),
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
    ),
    //------------End of Items Screen section (Items Tab)------------
  ];

  @override
  Widget build(BuildContext context) {
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
        body: Center(child: _widgets.elementAt(_index)),
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
    List<String> match = [];
    var result;
    int counter = 0;
    ItemDatabase item;
    int length = 0;
    for (var item in items) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        match.add(item.name);
        length++;
      }
    }
    return ListView.builder(
        itemCount: length,
        itemBuilder: (context, int index) {
          result = match[index];
          item = items[index];
          int counter = 0;
          for (ItemDatabase i in items) {
            if (i.name.toLowerCase().contains(match[index].toLowerCase())) {
              item = items[counter];
            }
            counter++;
          }
          return new ListTile(
            title: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text(item.name),
                  Spacer(),
                  Text("\$" + item.price.toString() + "\t"),
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> match = [];
    String result;
    int length = 0;
    for (var item in items) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        match.add(item.name);
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
  }
}
