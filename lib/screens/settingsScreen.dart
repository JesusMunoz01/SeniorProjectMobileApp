import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/createAccScreen.dart';
import 'package:sp_grocery_application/screens/loginScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mainScreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles/username");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          
        ]
      ),
      body: Center(
        child: Column(
          children: [Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)), 
          Text("Settings", style: TextStyle(fontSize: 24, fontFamily: 'Montserrat')),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
          ListTile(title: 
              Text("Personal Info", textAlign: TextAlign.center,),
              onTap:() {
                
              },
          ),
          ListTile(title: 
              Text("Budget", textAlign: TextAlign.center,),
              onTap:() {
                
              },
          ),
          ListTile(title: 
              Text("Logout", textAlign: TextAlign.center),
              onTap:() {
                
              },
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 350)),
          ListTile(title: 
              Text("Delete Account", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 184, 13, 1)),),
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => SecondScreen())));
              },
          ),
          ],
        ),
      ),   
    );
  }
}
