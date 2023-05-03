import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/createAccScreen.dart';
import 'package:sp_grocery_application/screens/loginScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/userDatabase.dart';
import 'mainScreen.dart';

class SettingsScreen extends StatefulWidget {
  UserDatabase local;
  String user;
  SettingsScreen(this.local, this.user);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController balance = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles/username");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              onTap:() => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('New Budget'),
                  content: TextField(
                    controller: balance,
                    decoration: InputDecoration(
                    icon: Icon(Icons.attach_money_rounded),
                    hintText: 'Enter value',
                    border: OutlineInputBorder(),
                ),
              ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{ 
                final snapshot = await FirebaseDatabase.instance.ref("profiles/${widget.user}");
                await snapshot.update({"Budget": balance.text});
                Navigator.pop(context, 'OK');},
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
          ),
          ListTile(title: 
              Text("Logout", textAlign: TextAlign.center),
              onTap:() {
                widget.local.isLogged = false;
                Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondScreen(widget.local)), (route) => false);
              },
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 350)),
          ListTile(title: 
              Text("Delete Account", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 184, 13, 1)),),
              onTap:() async{
                await FirebaseDatabase.instance.ref("profiles/${widget.user}").remove();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => SecondScreen(widget.local))), (route) => route.isFirst);
              },
          ),
          ],
        ),
      ),   
    );
  }
}
