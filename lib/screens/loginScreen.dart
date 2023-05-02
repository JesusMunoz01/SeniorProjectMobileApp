import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/createAccScreen.dart';
import 'package:sp_grocery_application/screens/infoScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/itemDatabase.dart';
import 'package:sp_grocery_application/utils/userDatabase.dart';
import 'mainScreen.dart';

class SecondScreen extends StatefulWidget {
  UserDatabase local;
  SecondScreen(this.local);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  void initState() {
    super.initState();
    //navigateToMain();
  }
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles/username");
  DatabaseReference data = FirebaseDatabase.instance.ref("items");

  navigateToMain(){
    if(widget.local.isLogged == true)
    Navigator.push(context,MaterialPageRoute(
      builder: (context) => MainScreen(_username.text, widget.local))).then((_) => navigateToMain());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF79802),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            ),
            Container(child: Image.asset('assets/images/newflan.png'), width: 300, height: 300,),
            /*
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "Login",
                key: Key("secondScreenTest"),
                style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
              ),
            )*/
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                key: Key("usernameTextField"),
                controller: _username,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  //border: OutlineInputBorder(),
                  label: Text(
                    'Username',
                    style: TextStyle(color: Colors.black),
                    key: Key("usernameText"),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                key: Key("passwordTextField"),
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  //border: OutlineInputBorder(),
                  label: Text(
                    'Password',
                    key: Key("passwordText"),
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
                  key: Key("loginButton"),
                  child: const Text(
                    'Login',
                    key: Key("loginTextButton"),
                  ),
                  onPressed: () async {
                    final snapshot = await FirebaseDatabase.instance
                        .ref("profiles/${_username.text}/username")
                        .get();
                    final passSnapshot = await FirebaseDatabase.instance
                        .ref("profiles/${_username.text}/password")
                        .get();
                    final budgetSnapshot = await FirebaseDatabase.instance
                        .ref("profiles/${_username.text}/Budget")
                        .get();
                    final firstLog = await FirebaseDatabase.instance
                        .ref("profiles/${_username.text}/firstLog")
                        .get();
                    if (_username.text == snapshot.value.toString() &&
                        _password.text.length > 8 &&
                        _password.text == passSnapshot.value.toString()) {
                      // widget.local.budget = double.parse(budgetSnapshot.value);
                      widget.local.isLogged = true;
                      if(firstLog.value == true)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoScreen(_username.text, widget.local)));
                      else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(_username.text, widget.local))).then((_) => navigateToMain());
                    }
                  },
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => createAccScreen(widget.local)));
                },
                child: Text(
                  "Create an Account",
                  style: TextStyle(color: Colors.black),
                  key: Key("createAccText"),
                ),
                key: Key("createAccButton"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
