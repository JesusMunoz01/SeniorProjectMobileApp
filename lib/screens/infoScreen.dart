import 'package:flutter/material.dart';
import 'package:sp_grocery_application/screens/createAccScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:firebase_database/firebase_database.dart';

class InfoScreen extends StatefulWidget {
  String user;
  InfoScreen(this.user);
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
      Text("Enter your name"),
      Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
      TextField(key: Key("nameTextField"), controller: _name, decoration: InputDecoration(border: OutlineInputBorder(),
                //hintText: "James",
                label: Text('Name',key: Key("nameText"),)), ),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 1;});}, child: Text("Submit"))])),),

    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      TextField(key: Key("ageTextField"), controller: _age, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Age',key: Key("ageText"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 2;});}, child: Text("Submit"))])),), 

    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      TextField(key: Key("sexTextField"), controller: _sex, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Sex',key: Key("sexText"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 3;});}, child: Text("Submit"))]))), 
    
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      TextField(key: Key("weightTextField"), controller: _weight, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Weight',key: Key("weightText"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 4;});}, child: Text("Submit"))]))), 
    
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      TextField(key: Key("heightTextField"), controller: _height, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Height',key: Key("heightText"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 5;});}, child: Text("Submit"))]))), 
    
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      TextField(key: Key("budgetTextField"), controller: _budget, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Budget',key: Key("budgetText"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () {setState(() {_index = 6;});}, child: Text("Submit"))]))),
                
    Container(padding: EdgeInsets.fromLTRB(20,375,20,0), child: Center(child: Column(children: [
      TextField(key: Key("timeFrameTextField"), controller: _timeFrame, decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text('Time Frame',key: Key("timeFrameText"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(onPressed: () async{
        DatabaseReference userInfo = FirebaseDatabase.instance.ref("profiles/${widget.user}");
          await userInfo.update({
            "Name": _name.text,
            "Age": _age.text,
            "Sex": _sex.text,
            "Weight" : _weight.text,
            "Height" : _height.text,
            "Budget" : _budget.text,
            "Time Frame" : _timeFrame.text});
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user)));}, child: Text("Submit"))]))),            
  ];

        return Scaffold(
        body:Center(child: _widgets.elementAt(_index)),
      );
  }
}
