import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sp_grocery_application/screens/itemsScreen.dart';
import 'package:sp_grocery_application/screens/mainScreen.dart';
import 'package:sp_grocery_application/screens/settingsScreen.dart';
import 'package:sp_grocery_application/utils/API.dart';
import 'package:sp_grocery_application/config/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp_grocery_application/utils/itemDatabase.dart';
import 'package:sp_grocery_application/utils/userDatabase.dart';

class MainScreen extends StatefulWidget {
  UserDatabase local;
  String user;
  MainScreen(this.user, this.local);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  int qty = 0;
  int oldIndex = 0;
  Future<String> futureP;
  Future<dynamic> futureI;
  Future<dynamic> futureU;
  Future<dynamic> futureM;
  double budget;
  String money;
  int itemNum = 0;
  int accPress = 0;
  int accItemCount = 0;
  bool update = true;
  String id = "701111";
  bool fav = false;
  bool hasFavorite = false;
  bool alreadyFalse = false;
  bool otherFavs = false;
  bool accHasItems = false;
  bool dispNoItemsText = false;
  Set<String> favItems = Set<String>();
  Set<String> localFav = Set<String>();
  Set<String> itemCount = Set<String>();
  @override
  void initState() {
    super.initState();
    //futureP = GroceryAPI.fetchPrice(httpClient, id);
    futureI = databaseSingle();
    futureU = databaseSingleFav();
    futureM = databaseSingleMeal();
    getBalance();
    getSpent();
    checkFav();
    checkMeal();
    checkItems();
  }

  getBalance() async{
    final budgetSnapshot = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}/Budget")
                        .get();
     widget.local.budget = double.parse(budgetSnapshot.value);
  }

  getSpent() async{
    final budgetSnapshot = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}/Spent")
                        .get();
     widget.local.spent = double.parse(budgetSnapshot.value.toString());
  }

  checkFav() async{
    final fav = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}/hasFav")
                        .get();
     widget.local.hasFavs = fav.value;
  }

  checkMeal() async{
    final fav = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}/hasMeal")
                        .get();
     widget.local.hasMeal = fav.value;
  }
  checkItems() async{
    final fav = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}/hasItems")
                        .get();
     widget.local.hasItems = fav.value;
  }

  databaseSingle() async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('items/itemList').get();
    if (snapshot.exists){
      return(snapshot.value);
    }
  }

  databaseBudget() async{
  final ref = FirebaseDatabase.instance.ref();
  final budget = await FirebaseDatabase.instance.ref("profiles/${widget.user}/Budget").get();
    return double.parse(budget.value);
  }

  databaseSingleFav() async{
  final ref1 = FirebaseDatabase.instance.ref();
  final snapshot1 = await ref1.child('profiles/${widget.user}/items').get();
    if (snapshot1.exists){
      return(snapshot1.value);
    }
    else
      return <dynamic, dynamic>{};
  }

  databaseSingleMeal() async{
  final ref1 = FirebaseDatabase.instance.ref();
  final snapshot1 = await ref1.child('profiles/${widget.user}/meals/meal0').get();
    if (snapshot1.exists){
      return(snapshot1.value);
    }
    else
      return <dynamic, dynamic>{};
  }

  databaseMeals() async{
  final ref1 = FirebaseDatabase.instance.ref();
  final snapshot1 = await ref1.child('profiles/${widget.user}/meals').get();
    if (snapshot1.exists){
      return(snapshot1.value);
    }
    else
      return <dynamic, dynamic>{};
  }

  setItems() async{
    final fav = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}");
     await fav.update({"hasItems" : true});
  }

  setMeals() async{
    final fav = await FirebaseDatabase.instance
                        .ref("profiles/${widget.user}");
     await fav.update({"hasMeal" : true});
  }


  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference newMyRef = FirebaseDatabase.instance.ref("items/itemList");
  ItemDatabase testItem;
  List<ItemDatabase> testItems = getItem();
  static double price;
  List<dynamic> itemList;


  var sections = ["Favorite", "Add to meal"];

  @override
  Widget build(BuildContext context) {
    widget.local.isLogged = true;
    widget.local.favCheck = 0;
    otherFavs = false;
  // List containing two screens (Home and Items)
  List<Widget> _widgets = <Widget>[
    //--------------Main Screen Section (Home tab)--------------
    FutureBuilder<dynamic>(
      future: futureU,
      initialData: null,
      builder: (context, AsyncSnapshot newSnapshot) {
      if (newSnapshot.hasData && newSnapshot.connectionState == ConnectionState.done) {
        Map map = newSnapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        "User Budget\n" + "\$${widget.local.spent.toStringAsFixed(2)}/\$${widget.local.budget}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                        key: Key("budgetText"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Text(
                        "Favorites",
                        style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                        key: Key("favoriteText"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    widget.local.hasFavs ? 
                    SizedBox(height: 200,child:
                      ListView.builder( 
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: map.length,
                      itemBuilder:(context, index) {
                        String key = map.keys.elementAt(index);
                        widget.local.itemCount = map.length;
                        accPress = 0;
                        if(map[key]["isFav"] == false && otherFavs == false){
                            otherFavs = false;
                        }
                        else otherFavs = true;
                        if(otherFavs == false){
                          if(alreadyFalse == false){
                            alreadyFalse = true;
                            return Container(child: Text("No favorites", textAlign: TextAlign.center,));}
                            else return Container();
                        }
                        else{
                        otherFavs = true;
                        if(map[key]["isFav"] == true){
                        return Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                              Expanded(child:Text("${map[key]["item"]}", textScaleFactor: 1,)),
                              Spacer(),
                              Text("\$" + map[key]["price"].toString() + "\t", textScaleFactor: 1,),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async{
                                    if(widget.local.GetCount(index) > 0){
                                    int iAmnt;
                                    widget.local.changeSpent(-map[key]["price"]);
                                    widget.local.AddCount(index, -1);
                                    iAmnt = map[key]["amount"];
                                    if(map[key]["isFav"] == true){
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${map[key]["id"]}");
                                    await currentItem.update({"amount" : iAmnt - widget.local.GetCount(index), 
                                      "isFav": true, "item":map[key]["item"], "id":map[key]["id"], "price":map[key]["price"]});}
                                    else{
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${map[key]["id"]}");
                                    await currentItem.update({"amount" : iAmnt - widget.local.GetCount(index), 
                                      "isFav": true, "item":map[key]["item"], "id":map[key]["id"], "price":map[key]["price"]});}
                                    setState(() {
                                      qty--;
                                    });
                                    }
                                  },
                                  child: Text(
                                    "-",
                                    textScaleFactor: 1,
                                  )),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "QTY:",
                                      textScaleFactor: 0.75,
                                    ),
                                    Text(
                                      "${widget.local.GetCount(index)}",
                                      textScaleFactor: 0.75,
                                    )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async{
                                    int iAmnt;
                                    widget.local.changeSpent(map[key]["price"]);
                                    widget.local.AddCount(index, 1);
                                    if(iAmnt == null) iAmnt = 0;
                                    else iAmnt = map[key]["amount"];
                                    if(map[key]["isFav"] == true){
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${map[key]["id"]}");
                                    await currentItem.update({"amount" : iAmnt + widget.local.GetCount(index), 
                                      "isFav": true, "item":map[key]["item"], "id":map[key]["id"], "price":map[key]["price"]});}
                                    else{
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${map[key]["id"]}");
                                    await currentItem.update({"amount" : iAmnt + widget.local.GetCount(index), 
                                      "isFav": false, "item":map[key]["item"], "id":map[key]["id"], "price":map[key]["price"]});}
                                    setState(() {
                                      qty++;
                                    });
                                  },
                                  child: Text("+"))
                            ]));}
                            else return Container();}
                      }),) :
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 200), child: Text("No favorites"),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0), child: Text("Account",
                        style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                        key: Key("accountText"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      widget.local.hasItems ?
                      SizedBox(height: 200, child:
                      ListView.builder( 
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: map.length,
                      itemBuilder:(context, index) {
                        String key = map.keys.elementAt(index);
                        widget.local.itemCount = map.length;
                        int nullContainer;
                        if(map[key]["amount"] == null) nullContainer = 0;
                        else nullContainer = map[key]["amount"];
                        accPress = 0;
                        int nullStorage;
                        if(map[key]["amount"] == null) nullStorage = 0;
                        else nullStorage = map[key]["amount"];
                        if(nullStorage < 1 && accHasItems == false){
                            accHasItems = false;
                        }
                        else accHasItems = true;
                        if(accHasItems == false){
                          if(dispNoItemsText == false && index == map.length - 1){
                            dispNoItemsText = true;
                            return Container(child: Text("No Items", textAlign: TextAlign.center,));}
                            else return Container();
                        }
                        else{
                        if(nullContainer > 0){
                          accItemCount++;
                          accHasItems = true;
                          dispNoItemsText = true;
                        return Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                              Expanded(child:Text("${map[key]["item"]}", textScaleFactor: 1,)),
                              Spacer(),
                              Text("Quantity Owned: " + map[key]["amount"].toString() + "\t", textScaleFactor: 1,),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async{
                                    int iAmnt;
                                    accPress += 1;
                                    widget.local.changeSpent(-map[key]["price"]);
                                    // final itemAmount = await FirebaseDatabase.instance
                                    //   .ref("profiles/${widget.user}/items/${map[key]["amount"]}").get();
                                    // if(itemAmount.value == null) iAmnt = 0;
                                    // else iAmnt = int.parse(itemAmount.value.toString());
                                    iAmnt = map[key]["amount"];
                                    if(map[key]["isFav"] == true){
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${map[key]["id"]}");
                                    await currentItem.update({"amount" : iAmnt - accPress, 
                                      "isFav": true, "item":map[key]["item"], "id":map[key]["id"], "price":map[key]["price"]});}
                                    else{
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${map[key]["id"]}");
                                    await currentItem.update({"amount" : iAmnt - accPress, 
                                      "isFav": false, "item":map[key]["item"], "id":map[key]["id"], "price":map[key]["price"]});}
                                      final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}");
                                    await snapshot.update({"Spent": widget.local.spent});
                                      if(iAmnt == 1)
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local)));
                                      setState(() {
                                        map[key]["amount"] = map[key]["amount"] - 1;
                                        widget.local.spent;
                                      });
                                  },
                                  child: Text("-")),
                              Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                            ]));}
                            else return Container();
                      }})) : 
                    Container(child: Text("No items"), padding: EdgeInsets.fromLTRB(0, 0, 0, 150),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: Size(100, 50)),
                        key: Key("mainScreenButton"),
                        onPressed: () async {widget.local.clearVal();
                          final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}");
                                    await snapshot.update({"Spent": widget.local.spent});
                          setState(() {
                            widget.local.spent;
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local)));
                        },
                        child: Text(
                          "Confirm",
                          key: Key("buttonText"),
                        ),
                      ),
                    ),
                  ],
                );
      }
      return CircularProgressIndicator();}),
                // ---------End of Main Screen section (Home Tab)-----------

                // -----------Items Screen Section (Items tab)---------------
                FutureBuilder<dynamic>(
                  future: futureI,
                  initialData: null,
                  builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    //itemList = snapshot.data;
                    //List<dynamic> set = itemList.map((itemList) => itemList['item'] as dynamic).toList();
                    List<dynamic> set = snapshot.data as List<dynamic>;
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                      child: Text(
                        "Items",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                        key: Key("itemsMainText"),
                      ),
                    ),
                  SizedBox(height: 580,child:
                  ListView.builder( 
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: set.length,
                  itemBuilder:(context, index) {
                   bool first = true;
                   bool pressed = favItems.contains(set[index]["id"]);
                   localFav = widget.local.favItems;
                   bool localP = localFav.contains(set[index]["id"]);
                    return Column(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),

                        ExpansionTile(controlAffinity: ListTileControlAffinity.leading ,
                        title:
                        Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                            // if(index > 20 && index <= 25)
                            //   FutureBuilder<String>(
                            //     future: GroceryAPI.fetchPrice(httpClient, set[index]["id"]),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData && itemNum < 2) {
                            //         DatabaseReference setAPIPrice = FirebaseDatabase.instance.ref("items/itemList/${index}");
                            //         setAPIPrice.update({"price": double.parse(snapshot.data)});
                            //        } else if (snapshot.hasError) {
                            //          return Text('${snapshot.error}');
                            //        }
                            //        return CircularProgressIndicator();
                            //      },
                            //    ),
                              Expanded(child:Text(set[index]["item"], textScaleFactor: 0.85,)),
                              Spacer(),
                              Text("\$" + set[index]["price"].toString() + "\t", textScaleFactor: 0.85,),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async{
                                    int iAmnt;
                                    bool isFavorited;
                                    if(widget.local.GetCount(index) > 0){
                                      widget.local.changeSpent(-set[index]["price"]);
                                    final itemAmnt = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${set[index]["id"]}").get();
                                    Map temp = itemAmnt.value;
                                    if(itemAmnt.value == null) {iAmnt = 0; isFavorited = false;}
                                    else {iAmnt = temp["amount"]; isFavorited = temp["isFav"];}
                                    if(isFavorited == true){
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${set[index]["id"]}");
                                    await currentItem.update({"amount" : iAmnt - widget.local.GetCount(index), 
                                      "isFav": true, "item":set[index]["item"], "id":set[index]["id"], "price":set[index]["price"]});}
                                    else{
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${set[index]["id"]}");
                                    await currentItem.update({"amount" : iAmnt - widget.local.GetCount(index), 
                                      "isFav": false, "item":set[index]["item"], "id":set[index]["id"], "price":set[index]["price"]});}
                                      widget.local.AddCount(index, -1);
                                    setState(() {
                                      qty--;
                                    });
                                    }
                                  },
                                  child: Text(
                                    "-",
                                    textScaleFactor: 1,
                                  )),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "QTY:",
                                      textScaleFactor: 0.75,
                                    ),
                                    Text(
                                      "${widget.local.GetCount(index)}",
                                      textScaleFactor: 0.75,
                                    )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  key: Key("itemAdd${index}"),
                                  onPressed: () async{
                                    int iAmnt;
                                    bool isFavorited;
                                    widget.local.changeSpent(set[index]["price"]);
                                    widget.local.AddCount(index, 1);
                                    final itemAmnt = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${set[index]["id"]}").get();
                                    Map temp = itemAmnt.value;
                                    if(itemAmnt.value == null) {iAmnt = 0; isFavorited = false;}
                                    else {iAmnt = temp["amount"]; isFavorited = temp["isFav"];}
                                    if(iAmnt == null) iAmnt = 0;
                                    if(isFavorited == true){
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${set[index]["id"]}");
                                    await currentItem.update({"amount" : iAmnt + widget.local.GetCount(index), 
                                      "isFav": true, "item":set[index]["item"], "id":set[index]["id"], "price":set[index]["price"]});}
                                    else{
                                    setItems();
                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}/items/${set[index]["id"]}");
                                    await currentItem.update({"amount" : iAmnt + widget.local.GetCount(index), 
                                      "isFav": false, "item":set[index]["item"], "id":set[index]["id"], "price":set[index]["price"]});}
                                    setState(() {
                                      qty++;
                                    });
                                  },
                                  child: Text("+"))
                            ]),
                        //onTap: () {},
                      ),
                      children: [   
                        Row(children: [
                          IconButton(onPressed: () async{   
                                final ref1 = FirebaseDatabase.instance.ref();
                                //final favorite = await ref1.child("profiles/${widget.user}/items/${set[index]["id"]}").get();
                                final hasFav = await FirebaseDatabase.instance.ref("profiles/${widget.user}");
                                await hasFav.update({"hasFav": true});

                                setState((){
                                  if(pressed || localP){
                                    widget.local.favItems.remove(set[index]['id']);
                                    favItems.remove(set[index]['id']); 
                                  }else{
                                    widget.local.favItems.add(set[index]['id']);
                                    favItems.add(set[index]['id']); 
                                  }              
                                  });
                                
                                if(!pressed || !localP){
                                    final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}/items/${set[index]["id"]}");
                                    await snapshot.update({"isFav": true, "item":set[index]["item"], "id":set[index]["id"], "price":set[index]["price"]});
                                }else{
                                  final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}/items/${set[index]["id"]}");
                                    await snapshot.update({"isFav": false, "item":set[index]["item"], "id":set[index]["id"], "price":set[index]["price"]});
                                }
                              }, 
                              icon: pressed || localP ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
                              Text("Add to favorites")
                        ],),
                        Row(children: [
                          Padding(padding: EdgeInsets.fromLTRB(14, 0, 0, 0)),
                          GestureDetector(
                            child: Icon(Icons.dinner_dining),
                            onTap:() => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Add to meals'),
                                content: GestureDetector(child: Text("Meal 0"), onTap: () async{
                                  final addMealDB = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}/meals/meal0/${set[index]["item"]}");
                                    await addMealDB.update({"item" : set[index]["item"]});
                                    setMeals();
                                },),
                        actions: <Widget>[
                      //     TextButton(onPressed: (){showDialog<String>(
                      //         context: context,
                      //         builder: (BuildContext context) => AlertDialog(
                      //           title: const Text('Enter meal name'),
                      //           content: TextField(),
                      //           actions: <Widget>[
                      //             TextButton(
                      //               onPressed: () => Navigator.pop(context, 'Cancel'),
                      //               child: const Text('Cancel'),
                      //             ),
                      //             TextButton(
                      //               onPressed: () async{ 
                      //                 Navigator.pop(context, 'OK');},
                      //               child: const Text('Confirm'),
                      //             ),
                      //           ],
                      // ));}, child: const Text('Create a meal')),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async{ 
                              Navigator.pop(context, 'OK');},
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ),
                          ),
                              Padding(padding: EdgeInsets.fromLTRB(11, 0, 0, 0)),
                              Text("Add to meals")
                        ],),
                      ],
                    )
                ],);},)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        key: Key("itemsScreenButton"),
                        onPressed: () async{widget.local.clearVal();
                          final snapshot = await FirebaseDatabase.instance
                                      .ref("profiles/${widget.user}");
                                      await snapshot.update({"Spent": widget.local.spent});
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local)));
                        },
                        child: Text(
                          "Confirm",
                          key: Key("itemsButtonText"),
                        ),
                      ),
                    ),
                  ]);
              }return CircularProgressIndicator();}), 
                //------------End of Items Screen section (Items Tab)------------

                // -----------Meals Screen Section (Meal tab)---------------
                 FutureBuilder<dynamic>(
      future: futureM,
      initialData: null,
      builder: (context, AsyncSnapshot newSnapshot) {
      if (newSnapshot.hasData && newSnapshot.connectionState == ConnectionState.done) {
        Map map = newSnapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Text(
                        "Meals",
                        style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                        key: Key("mealsText"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    widget.local.hasMeal ?
                    ExpansionTile(title: Text("Meal 0"), children: [SizedBox(width: 400, height: 50, 
                    child: ListView.builder(shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: map.length,
                  itemBuilder:(context, index) {
                    String key = map.keys.elementAt(index);
                    return Text("${map[key]["item"]}\n", textAlign: TextAlign.left,);
                  }),)],) :
                    Text("No meals"),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 400, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: Size(100, 50)),
                        key: Key("mealScreenButton"),
                        onPressed: () async{widget.local.clearVal();
                          final snapshot = await FirebaseDatabase.instance
                                    .ref("profiles/${widget.user}");
                                    await snapshot.update({"Spent": widget.local.spent});
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local)));
                        },
                        child: Text(
                          "Confirm",
                          key: Key("mealButtonText"),
                        ),
                      ),
                    ),
                  ],
                );
      }
      return CircularProgressIndicator();}),
                //------------End of Meals Screen section (Meals Tab)-----------
              ];

    // Scaffold
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF79802),
          leading: Icon(Icons.arrow_back, color: Colors.transparent,),
          actions: [
            IconButton(
              key: Key("searchButton"),
                onPressed: () {
                  showSearch(context: context, delegate: CustomSearch(widget.local, widget.user));
                },
                icon: Icon(Icons.search)),
            IconButton(
              key: Key("settingsButton"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen(widget.local, widget.user)));
                },
                icon: Icon(Icons.settings)),
          ],
        ),
        body:Center(child: _widgets.elementAt(_index)),
        bottomNavigationBar: BottomNavigationBar(
          key: Key("tabs"),
          selectedIconTheme: IconThemeData(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Colors.black),
          selectedItemColor: Colors.black,
          backgroundColor: Color(0xFFF79802),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, key: Key("homeTab"),),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_rounded, key: Key("itemsTab"),),
              label: 'Items',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ramen_dining_outlined, key: Key("mealTab"),),
              label: 'Meals',
            ),
          ],
          currentIndex: _index,
          onTap: (int value) {
            setState(() {
              oldIndex = _index;
              _index = value;
            });
             if(oldIndex != 0 && _index == 0){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(widget.user, widget.local)));
            }
          },
        ));
  }
}

  databaseSingle() async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('items/itemList').get();
    if (snapshot.exists){
      return(snapshot.value);
    }
  }
  Future<dynamic> searchRef = databaseSingle();

class CustomSearch extends SearchDelegate {
  List<ItemDatabase> items = getItem();
  UserDatabase local;
  String user;
  CustomSearch(this.local, this.user);
  int qty = 0;

  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSearch(context: context, delegate: CustomSearch(local, user));
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        key: Key("returnSearch"),
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.backspace));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: searchRef,
      builder: (context, snapshot) {
        if(snapshot.hasData){
    List<dynamic> sets = snapshot.data as List<dynamic>;
    List<String> match = [];
    var result;
    int counter = 0;
    var item;
    int length = 0;
    int amount = 0;
    for (var item in sets) {
      if (item['item'].toLowerCase().contains(query.toLowerCase())) {
        match.add(item['item']);
        length++;
        if(item["amount"] == null) amount = 0;
        else amount = item["amount"];
      }
    }
    return ListView.builder(
        itemCount: length,
        itemBuilder: (context, int index) {
          result = match[index];
          item = sets[index];
          int counter = 0;
          for (var i in sets) {
            if (i['item'].toLowerCase().contains(match[index].toLowerCase())) {
              item = sets[counter];
            }
            counter++;
          }
          return new ListTile(
            title: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                              Expanded(child:Text("${item["item"]}", textScaleFactor: 1,)),
                              Spacer(),
                              Text("\$" + item["price"].toString() + "\t", textScaleFactor: 1,),
                              Spacer(),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "Add to \nfavorites",
                                      textScaleFactor: 0.85,
                                    ),
                                    // Text(
                                    //   "${qty}",
                                    //   textScaleFactor: 0.75,
                                    // )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(minimumSize: Size(10, 15)),
                                  onPressed: () async{

                                    final currentItem = await FirebaseDatabase.instance
                                      .ref("profiles/${user}/items/${item["id"]}");
                                    await currentItem.update({"isFav": true, "item": item["item"], "id":item["id"], "price":item["price"]});},             
                                  child: Text("+"))
                            ]))
          );
        });
        }return CircularProgressIndicator();});
  }
  

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: searchRef,
      builder: (context, snapshot) {
        if(snapshot.hasData){
      List<dynamic> sets = snapshot.data as List<dynamic>;
      List<String> match = [];
      String result;
      int length = 0;
      for (var item in sets) {
        if (item["item"].toLowerCase().contains(query.toLowerCase())) {
          match.add(item["item"]);
          length++;
        }
      }
      return ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          result = match[index];
          return new GestureDetector(
            onTap: () {
              query = match[index];
              showResults(context);
            },
            child: ListTile(title: Text("${result}")),
          );
        },
      );
  } return CircularProgressIndicator();});
  }
}

/* ----------- Obtain Items in Database -----------------
  Future<dynamic> futureP;

  void initState() {
    super.initState();
    futureP = databaseSingle();
  }

  databaseSingle() async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('items/itemList').get();
    if (snapshot.exists){
      return(snapshot.value);
    }
  }

  // This goes inside a Widget, builds text & other functions
  FutureBuilder<dynamic>(
    future: futureP,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text('${snapshot.data}');
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return CircularProgressIndicator();
      },
  ),
  ----------------------------------------------*/

  /*  ------------Database Push----------
  // Replaces whats currently in database
                onPressed: () async {
                await newMyRef.set({
                  "item": testItem.name,
                  "id": testItem.id,
                   "price": testItem.price
                });
              },

  // Makes a new child and replaces whats inside
    onPressed: () async {
      await newMyRef.child(_username.text); // Makes child with given value (username.text)

      // Searches for the new ref (child) and inserts text
      DatabaseReference myNewRef = FirebaseDatabase.instance.ref("profiles/${_username.text}");
      await myNewRef.set({"username": _username.text,"password": _password.text,});
  ----------------------------------------------*/

  /* -------------API-----------
            FutureBuilder<String>(
              future: futureP,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  money = snapshot.data;
                  return Text('${snapshot.data}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            --------------------------------*/

  /*------------Old Body---------
  Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "User Budget\n" + "\$${500}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                  key: Key("budgetText"),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  "Recommended",
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                  key: Key("mainScreenText"),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              for (ItemDatabase item in testItems)
                ListTile(
                  title: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Text(item.name),
                        Spacer(),
                        Text("\$" + item.price.toString() + "\t"),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 20)),
                            onPressed: () {},
                            child: Text(
                              "-",
                              textScaleFactor: 1,
                            )),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "QTY:",
                                textScaleFactor: 0.75,
                              ),
                              Text(
                                "1",
                                textScaleFactor: 0.75,
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 20)),
                            onPressed: () {},
                            child: Text("+"))
                      ])),
                  //onTap: () {},
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: ElevatedButton(
                  key: Key("mainScrenButton"),
                  onPressed: () {},
                  child: Text(
                    "Test",
                    key: Key("buttonText"),
                  ),
                ),
              ),
            ],
          ),
          --------------------------------*/