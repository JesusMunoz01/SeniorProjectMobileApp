import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/loginScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mainScreen.dart';

class createAccScreen extends StatefulWidget {
  @override
  _createAccScreenState createState() => _createAccScreenState();
}

class _createAccScreenState extends State<createAccScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference newMyRef = FirebaseDatabase.instance.ref("profiles");
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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: Text(
                "Create An Account",
                key: Key("createAccScreenText"),
                style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                key: Key("createAccUsernameTextField"),
                controller: _username,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Username',
                    key: Key("createAccUsernameText"),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                key: Key("createAccPasswordTextField"),
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Password',
                    key: Key("createAccPasswordText"),
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                  key: Key("submitAccButton"),
                  child: const Text(
                    'Submit',
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
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen()));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
