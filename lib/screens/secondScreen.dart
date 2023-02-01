import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 400, 20, 0),
              child: Text(
                "Test Screen",
                key: Key("secondScreenTest"),
                style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text("Main Screen"),
                key: Key("secondScreenButtonTest"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
