import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:sp_grocery_application/utils/API.dart';
import 'package:sp_grocery_application/config/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/itemDatabase.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<String> futureP;
  String money;
  @override
  //void initState() {
  //  super.initState();
  //  futureP = GroceryAPI.fetchPrice(httpClient);
  //}
  FirebaseDatabase database = FirebaseDatabase.instance;
  //DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles");
  DatabaseReference newMyRef = FirebaseDatabase.instance.ref("items").push();
  ItemDatabase testItem = product1();
  List<ItemDatabase> testItems = getItem();
  /*
                  onPressed: () async {
                  await newMyRef.set({
                    "item": testItem.name,
                    "id": testItem.id,
                    "price": testItem.price
                  });
                },
  */
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
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag))
          ],
        ),
        body: Center(
          child: Column(
            children: [
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "Items",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                  key: Key("budgetText"),
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
        ),
        
        );
  }
}