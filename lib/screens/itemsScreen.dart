// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:sp_grocery_application/screens/mainScreen.dart';
// import 'package:sp_grocery_application/utils/API.dart';
// import 'package:sp_grocery_application/config/globals.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:sp_grocery_application/utils/itemDatabase.dart';

// class ItemsScreen extends StatefulWidget {
//   @override
//   _ItemsScreenState createState() => _ItemsScreenState();
// }

// class _ItemsScreenState extends State<ItemsScreen> {
//   int _index = 1;
//   Future<String> futureP;
//   String money;
//   @override
//   //void initState() {
//   //  super.initState();
//   //  futureP = GroceryAPI.fetchPrice(httpClient);
//   //}
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   //DatabaseReference myRef = FirebaseDatabase.instance.ref("profiles");
//   DatabaseReference newMyRef = FirebaseDatabase.instance.ref("items").push();
//   ItemDatabase testItem = product1();
//   List<ItemDatabase> testItems = getItem();
//   /*
//                   onPressed: () async {
//                   await newMyRef.set({
//                     "item": testItem.name,
//                     "id": testItem.id,
//                     "price": testItem.price
//                   });
//                 },
//   */

// /*
//   List<Widget> _widgets = <Widget>[
//     Column(
//       children: [
//         /* -------------API-----------
//             FutureBuilder<String>(
//               future: futureP,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   money = snapshot.data;
//                   return Text('${snapshot.data}');
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//                 return CircularProgressIndicator();
//               },
//             ),
//             --------------------------------*/
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
//           child: Text(
//             "Items",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
//             key: Key("budgetText"),
//           ),
//         ),
//         Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
//         for (ItemDatabase item in getItem())
//           ListTile(
//             title: Container(
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                   Text(item.name),
//                   Spacer(),
//                   Text("\$" + item.price.toString() + "\t"),
//                   ElevatedButton(
//                       style:
//                           ElevatedButton.styleFrom(minimumSize: Size(20, 20)),
//                       onPressed: () {},
//                       child: Text(
//                         "-",
//                         textScaleFactor: 1,
//                       )),
//                   Container(
//                     child: Column(
//                       children: [
//                         Text(
//                           "QTY:",
//                           textScaleFactor: 0.75,
//                         ),
//                         Text(
//                           "1",
//                           textScaleFactor: 0.75,
//                         )
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                       style:
//                           ElevatedButton.styleFrom(minimumSize: Size(20, 20)),
//                       onPressed: () {},
//                       child: Text("+"))
//                 ])),
//             //onTap: () {},
//           ),
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
//           child: ElevatedButton(
//             key: Key("mainScrenButton"),
//             onPressed: () {},
//             child: Text(
//               "Test",
//               key: Key("buttonText"),
//             ),
//           ),
//         ),
//       ],
//     ),
//     Column(
//       children: [
//         /* -------------API-----------
//             FutureBuilder<String>(
//               future: futureP,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   money = snapshot.data;
//                   return Text('${snapshot.data}');
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//                 return CircularProgressIndicator();
//               },
//             ),
//             --------------------------------*/
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
//           child: Text(
//             "Items",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
//             key: Key("budgetText"),
//           ),
//         ),
//         Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
//         for (ItemDatabase item in getItem())
//           ListTile(
//             title: Container(
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                   Text(item.name),
//                   Spacer(),
//                   Text("\$" + item.price.toString() + "\t"),
//                   ElevatedButton(
//                       style:
//                           ElevatedButton.styleFrom(minimumSize: Size(20, 20)),
//                       onPressed: () {},
//                       child: Text(
//                         "-",
//                         textScaleFactor: 1,
//                       )),
//                   Container(
//                     child: Column(
//                       children: [
//                         Text(
//                           "QTY:",
//                           textScaleFactor: 0.75,
//                         ),
//                         Text(
//                           "1",
//                           textScaleFactor: 0.75,
//                         )
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                       style:
//                           ElevatedButton.styleFrom(minimumSize: Size(20, 20)),
//                       onPressed: () {},
//                       child: Text("+"))
//                 ])),
//             //onTap: () {},
//           ),
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
//           child: ElevatedButton(
//             key: Key("mainScrenButton"),
//             onPressed: () {},
//             child: Text(
//               "Test",
//               key: Key("buttonText"),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ];
//   */

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   showSearch(context: context, delegate: CustomSearch());
//                 },
//                 icon: Icon(Icons.search)),
//             IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
//             IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag))
//           ],
//         ),
//         body: Center(
//           child: Column(
//             //_widgets.elementAt(_index) **Second option**
//             children: [
//               /* -------------API-----------
//               FutureBuilder<String>(
//                 future: futureP,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     money = snapshot.data;
//                     return Text('${snapshot.data}');
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//                   return CircularProgressIndicator();
//                 },
//               ),
//               --------------------------------*/
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
//                 child: Text(
//                   "Items",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
//                   key: Key("budgetText"),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
//               for (ItemDatabase item in testItems)
//                 ListTile(
//                   title: Container(
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                         Text(item.name),
//                         Spacer(),
//                         Text("\$" + item.price.toString() + "\t"),
//                         ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 minimumSize: Size(20, 20)),
//                             onPressed: () {},
//                             child: Text(
//                               "-",
//                               textScaleFactor: 1,
//                             )),
//                         Container(
//                           child: Column(
//                             children: [
//                               Text(
//                                 "QTY:",
//                                 textScaleFactor: 0.75,
//                               ),
//                               Text(
//                                 "1",
//                                 textScaleFactor: 0.75,
//                               )
//                             ],
//                           ),
//                         ),
//                         ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 minimumSize: Size(20, 20)),
//                             onPressed: () {},
//                             child: Text("+"))
//                       ])),
//                   //onTap: () {},
//                 ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
//                 child: ElevatedButton(
//                   key: Key("mainScrenButton"),
//                   onPressed: () {},
//                   child: Text(
//                     "Test",
//                     key: Key("buttonText"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.format_list_bulleted_rounded),
//               label: 'Items',
//             ),
//           ],
//           currentIndex: _index,
//           onTap: (int value) {
//             setState(() {
//               _index = value;
//             });
//             if (_index == 0) {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => MainScreen()));
//             }
//           },
//         ));
//   }
// }
