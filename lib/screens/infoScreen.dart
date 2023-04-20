import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/createAccScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/userDatabase.dart';

class InfoScreen extends StatefulWidget {
  String user;
  UserDatabase local;
  InfoScreen(this.user, this.local);
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
  int _index = 0;
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference userRef = FirebaseDatabase.instance.ref("profiles/username");

  @override
  Widget build(BuildContext context) {
      List<Widget> _widgets = <Widget>[
    Container(padding: EdgeInsets.fromLTRB(20,350,20,0), child: Center(child: Column(children: [
      Text("Enter your name", key: Key("nameText"),),
      Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
      TextField(key: Key("nameTextField"), controller: _name, decoration: InputDecoration(border: OutlineInputBorder(),
                //hintText: "James",
                label: Text('Name',key: Key("nameLabel"),)), ),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 1;});}, key: Key("nameButton"), child: Text("Submit"))])),),

    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      Text("Enter your age", key: Key("ageText"),),
      TextField(key: Key("ageTextField"), controller: _age, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Age',key: Key("ageLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 2;});}, key: Key("ageButton"), child: Text("Submit"))])),), 

    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      Text("Enter your gender", key: Key("sexText"),),
      TextField(key: Key("sexTextField"), controller: _sex, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Sex',key: Key("sexLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 3;});}, key: Key("sexButton"), child: Text("Submit"))]))), 
    
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      Text("Enter your weight", key: Key("weightText"),),
      TextField(key: Key("weightTextField"), controller: _weight, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Weight',key: Key("weightLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 4;});}, key: Key("weightButton"), child: Text("Submit"))]))), 
    
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      Text("Enter your height", key: Key("heightText"),),
      TextField(key: Key("heightTextField"), controller: _height, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Height',key: Key("heightLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 5;});}, key: Key("heightButton"), child: Text("Submit"))]))), 
    
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      Text("Enter your budget", key: Key("budgetText"),),
      TextField(key: Key("budgetTextField"), controller: _budget, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Budget',key: Key("budgetLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 6;});}, key: Key("budgetButton"), child: Text("Submit"))]))),
                
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      Text("Enter your time frame", key: Key("timeFrameText"),),
      TextField(key: Key("timeFrameTextField"), controller: _timeFrame, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Time Frame',key: Key("timeFrameLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(key: Key("timeFrameButton"),
        onPressed: () async{
        DatabaseReference userInfo = FirebaseDatabase.instance.ref("profiles/${widget.user}");
          await userInfo.update({
            "Name": _name.text,
            "Age": _age.text,
            "Sex": _sex.text,
            "Weight" : _weight.text,
            "Height" : _height.text,
            "Budget" : _budget.text,
            "Time Frame" : _timeFrame.text,
            "firstLog" : false});
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local)));}, child: Text("Submit"))]))),            
  ];

        return Scaffold(
        body:Center(child: _widgets.elementAt(_index)),
      );
  }
}
