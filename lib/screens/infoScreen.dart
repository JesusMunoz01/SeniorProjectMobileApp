import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/createAccScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _sex = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _budget = TextEditingController();
  TextEditingController _timeFrame = TextEditingController();
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles/username");
  DatabaseReference data = FirebaseDatabase.instance.ref("items");
  
  List<Widget> _widgets = <Widget>[
    Container(child: Center(child: Column(children: [
      TextField(key: Key("nameTextField"), controller: _name, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Name',key: Key("nameText"),)),)]))),

    Container(child: Center(child: Column(children: [
      TextField(key: Key("ageTextField"), controller: _age, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Age',key: Key("ageText"),)),)]))), 

    Container(child: Center(child: Column(children: [
      TextField(key: Key("sexTextField"), controller: _sex, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Sex',key: Key("sexText"),)),)]))), 
    
    Container(child: Center(child: Column(children: [
      TextField(key: Key("weightTextField"), controller: _weight, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Weight',key: Key("weightText"),)),)]))), 
    
    Container(child: Center(child: Column(children: [
      TextField(key: Key("heightTextField"), controller: _height, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Height',key: Key("heightText"),)),)]))), 
    
    Container(child: Center(child: Column(children: [
      TextField(key: Key("budgetTextField"), controller: _budget, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Budget',key: Key("budgetText"),)),)]))),
                
    Container(child: Center(child: Column(children: [
      TextField(key: Key("timeFrameTextField"), controller: _timeFrame, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Time Frame',key: Key("timeFrameText"),)),)]))),            
  ];

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
                key: Key("usernameTextField"),
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
                key: Key("passwordTextField"),
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
                        .ref("profiles/${_username.text}/username")
                        .get();
                    final passSnapshot = await FirebaseDatabase.instance
                        .ref("profiles/${_username.text}/password")
                        .get();
                    if (_username.text == snapshot.value.toString() &&
                        _password.text.length > 8 &&
                        _password.text == passSnapshot.value.toString()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(_username.text)));
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
                          builder: (context) => createAccScreen()));
                },
                child: Text(
                  "Create an Account",
                  style: TextStyle(color: Colors.blue),
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
