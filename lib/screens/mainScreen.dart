import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:sp_grocery_application/utils/API.dart';
import 'package:sp_grocery_application/config/globals.dart';
import 'package:firebase_database/firebase_database.dart';

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
  DatabaseReference myRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await myRef.set({"username": "Jesus"});
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
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text(
                  "User Budget\n\$${500}",
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                  key: Key("budgetText"),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: Text(
                  "Test Screen",
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                  key: Key("mainScreenText"),
                ),
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
        bottomNavigationBar:
            BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'Items',
          ),
        ]));
  }
}
