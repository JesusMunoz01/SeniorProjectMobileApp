import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/loginScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/userDatabase.dart';
import 'mainScreen.dart';

class createAccScreen extends StatefulWidget {
  UserDatabase local;
  createAccScreen(this.local);
  @override
  _createAccScreenState createState() => _createAccScreenState();
}

class _createAccScreenState extends State<createAccScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference newMyRef = FirebaseDatabase.instance.ref("profiles");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF79802),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          key: Key("createAccBack"),
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
            Row(children: [
              Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 40, 0),
              child: Text(
                "Create \nNew \nAccount!!!",
                key: Key("createAccScreenText"),
                style: TextStyle(fontSize: 48, fontFamily: 'Arial', fontWeight: FontWeight.bold),
              ),
            ),],),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                key: Key("createAccUsernameField"),
                controller: _username,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  label: Text(
                    'Username',
                    style: TextStyle(color: Colors.black),
                    key: Key("createAccUsernameText"),
                  ),
                ),
                
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                key: Key("createAccPasswordField"),
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  label: Text(
                    'Password',
                    style: TextStyle(color: Colors.black),
                    key: Key("createAccPasswordText"),
                  ),
                ),
              ),
            ),
            Container(
                width: 200,
                height: 69,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  key: Key("submitAccButton"),
                  child: const Text(
                    'Create Account', style: TextStyle(color: Colors.white),
                    key: Key("submitAccTextButton"),
                  ),
                  onPressed: () async {
                    if (_password.text.length > 8 &&
                        _username.text.length > 4) {
                      await newMyRef.child(_username.text);
                      DatabaseReference myNewRef = FirebaseDatabase.instance
                          .ref("profiles/${_username.text}");
                      await myNewRef.set({
                        "username": _username.text,
                        "password": _password.text,
                        "firstLog": true,
                        "hasFav": false,
                        "hasMeal": false,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen(widget.local)));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
