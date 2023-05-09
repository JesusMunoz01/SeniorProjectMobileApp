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
  int _timeFrame = 0;
  int _index = 0;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool _check = true;
  @override
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference userRef = FirebaseDatabase.instance.ref("profiles/username");
    navigateToMain(){
    if(widget.local.isLogged == true)
    Navigator.push(context,MaterialPageRoute(
      builder: (context) => MainScreen(widget.user, widget.local))).then((_) => navigateToMain());
  }

  @override
  Widget build(BuildContext context) {
      List<Widget> _widgets = <Widget>[
    //////////////////////////////////////// NAME //////////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      //Container(child: Image.asset('assets/images/info1.0.png'), width: 300, height: 300,),
      Text("Enter Your Name", key: Key("nameText"), style: TextStyle(fontSize: 20)),
      Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
      TextField(key: Key("nameTextField"),
                controller: _name, 
                decoration: InputDecoration(border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white/*fromARGB(255, 250, 203, 127)*/,
                //hintText: "James",
                label: Text('Name',key: Key("nameLabel"),)), ),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30)),
      ElevatedButton(onPressed: () {setState(() {_index = 1;});}, 
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)), 
      key: Key("nameButton"), child: Text("Submit")),
      Container(child: Image.asset('assets/images/info1.0.png'), width: 300, height: 300,),])),),
      //////////////////////////////////////////////////////////////////////////////////////////////
      
    ////////////////////////////////////// AGE /////////////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      Text("Enter Your Age", key: Key("ageText"), style: TextStyle(fontSize: 20)),
      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
      TextField(key: Key("ageTextField"), 
                controller: _age, 
                decoration: InputDecoration(border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                label: Text('Age',key: Key("ageLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30)),
      ElevatedButton(onPressed: () {setState(() {_index = 2;});},
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)),
      key: Key("ageButton"), child: Text("Submit")),
      Container(child: Image.asset('assets/images/info2.png'), width: 300, height: 300,),])),),
      //////////////////////////////////////////////////////////////////////////////////////////////
      
    //////////////////////////////////////// SEX ////////////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      Text("Enter Your Sex", key: Key("sexText"), style: TextStyle(fontSize: 20)),
      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
      TextField(key: Key("sexTextField"), 
                controller: _sex, 
                decoration: InputDecoration(border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                label: Text('Sex',key: Key("sexLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30)),
      ElevatedButton(onPressed: () {setState(() {_index = 3;});},
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)), 
      key: Key("sexButton"), child: Text("Submit")),
      Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 10)),
      Container(child: Image.asset('assets/images/happyFlan.png'), width: 70, height: 70,)]))),
      ////////////////////////////////////////////////////////////////////////////////////////////// 
      
    ///////////////////////////////////////// WEIGHT ///////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      Text("Enter Your Weight", key: Key("weightText"), style: TextStyle(fontSize: 20)),
      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
      TextField(key: Key("weightTextField"), 
                controller: _weight, 
                decoration: InputDecoration(border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                label: Text('Weight',key: Key("weightLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30)),
      ElevatedButton(onPressed: () {setState(() {_index = 4;});},
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)),
      key: Key("weightButton"), child: Text("Submit")),
      Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 10)),
      Container(child: Image.asset('assets/images/happyFlan.png'), width: 70, height: 70,)]))),
      /////////////////////////////////////////////////////////////////////////////////////////////// 
    
    /////////////////////////////////////////// HEIGHT ////////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      Text("Enter Your Height", key: Key("heightText"), style: TextStyle(fontSize: 20)),
      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
      TextField(key: Key("heightTextField"), 
                controller: _height, 
                decoration: InputDecoration(border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                label: Text('Height',key: Key("heightLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30)),
      ElevatedButton(onPressed: () {setState(() {_index = 5;});},
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)),
      key: Key("heightButton"), child: Text("Submit")),
      Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 10)),
      Container(child: Image.asset('assets/images/happyFlan.png'), width: 70, height: 70,)]))),
      ///////////////////////////////////////////////////////////////////////////////////////////////// 
    
    ////////////////////////////////////////// BUDGET //////////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      Text("Enter Your Budget", key: Key("budgetText"), style: TextStyle(fontSize: 20),),
      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
      TextField(key: Key("budgetTextField"), 
                controller: _budget, 
                decoration: InputDecoration(border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                label: Text('Budget',key: Key("budgetLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30)),
      ElevatedButton(onPressed: () {setState(() {_index = 6;});},
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)),
      key: Key("budgetButton"), child: Text("Submit")),
      Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 10)),
      Container(child: Image.asset('assets/images/happyFlan.png'), width: 70, height: 70,)]))),
      //////////////////////////////////////////////////////////////////////////////////////////////////
                
    //////////////////////////////////////// TIME FRAME ////////////////////////////////////////////////
    Container(padding: EdgeInsets.fromLTRB(20,200,20,0), child: Center(child: Column(children: [
      Text("Select Your Time Frame", key: Key("timeFrameText"), style: TextStyle(fontSize: 20),),
      // TextField(key: Key("timeFrameTextField"), controller: _timeFrame, decoration: InputDecoration(border: OutlineInputBorder(),
      //           label: Text('Time Frame',key: Key("timeFrameLabel"),)),),
      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
      RadioListTile(
          title: const Text('1 Week'),
          value: selected1,
          groupValue: _check,
          onChanged: (value) {
            setState(() {
              if(selected1 == false){
              _timeFrame = 1;
              selected1 = !value;
              selected2 = false;
              selected3 = false;
              }
              else
              selected1 = value;

            });
          },
          
      ),
      RadioListTile(
          key: Key("option2"),
          title: const Text('2 Weeks'),
          value: selected2,
          groupValue: _check,
          onChanged: (value) {
            setState(() {
              _timeFrame = 2;
              if(selected2 == false){
              selected2 = !value;
              selected1 = false;
              selected3 = false;
              }
              else
              selected2 = !value;
            });
          },
      ),
      RadioListTile(
          title: const Text('Monthly'),
          value: selected3,
          groupValue: _check,
          onChanged: (value) {
            setState(() {
              _timeFrame = 4;
              if(selected3 == false){
              selected3 = !value;
              selected2 = false;
              selected1 = false;
              }
              else
              selected2 = !value;
            });
          },
          
      ),
      
      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
      ElevatedButton(key: Key("timeFrameButton"),
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF79802)),
        onPressed: () async{
        DatabaseReference userInfo = FirebaseDatabase.instance.ref("profiles/${widget.user}");
          await userInfo.update({
            "Name": _name.text,
            "Age": _age.text,
            "Sex": _sex.text,
            "Weight" : _weight.text,
            "Height" : _height.text,
            "Budget" : _budget.text,
            "Spent" : 0.0,
            "Time Frame" : _timeFrame,
            "firstLog" : false});
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local), )).then((_) => navigateToMain());}, child: Text("Submit")),
        Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 10)),
        Container(child: Image.asset('assets/images/happyFlan.png'), width: 70, height: 70,)]))),            
  ];

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,//Color.fromARGB(255, 245, 182, 80),
          body:Center(child: _widgets.elementAt(_index)),
          appBar: AppBar(backgroundColor: Color(0xFFF79802), centerTitle: true,
          title: Text("Step 1"), titleTextStyle: TextStyle(fontFamily: 'Arial', fontSize: 20)),
      );
  }
}