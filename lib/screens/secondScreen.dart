import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 400, 20, 0),
            child: Text(
              "Test Screen",
              style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    );
  }
}
