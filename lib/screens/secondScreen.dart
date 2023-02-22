import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mainScreen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles/username");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: Text(
                "Login",
                key: Key("secondScreenTest"),
                style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: _username,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Username',
                    key: Key("usernameText"),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Password',
                    key: Key("passwordText"),
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                  key: Key("loginButton"),
                  child: const Text(
                    'Login',
                    key: Key("loginTextButton"),
                  ),
                  onPressed: () async {
                    final snapshot = await FirebaseDatabase.instance
                        .ref("profiles/username")
                        .get();
                    if (_username == snapshot.value.toString() &&
                        _password.text.length > 8) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen()));
                    }
                  },
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text("Main Screen"),
                key: Key("secondScreenButtonTest"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
