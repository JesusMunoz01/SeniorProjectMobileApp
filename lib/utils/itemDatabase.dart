import 'package:firebase_database/firebase_database.dart';

class ItemDatabase {
  String name;
  String id;
  double price;
  List<dynamic> items;

  ItemDatabase(name, id, price) {
    this.name = name;
    this.id = id;
    this.price = price;
  }

  setPrice(price) {
    this.price = price;
  }

  setListVal(List<dynamic> test){
    this.items = test;
  }

  getList(){
    return items;
  }
}

ItemDatabase product1() {
  ItemDatabase p1 = ItemDatabase("Flour", "701111", 0.0);
  return p1;
}

ItemDatabase product2() {
  ItemDatabase product = ItemDatabase("Ground Beef", "703112", 0.0);
  return product;
}

ItemDatabase product3() {
  ItemDatabase product = ItemDatabase("Rice", "701312", 0.0);
  return product;
}

ItemDatabase product4() {
  ItemDatabase product = ItemDatabase("Bread", "702111", 0.0);
  return product;
}

ItemDatabase product5() {
  ItemDatabase product = ItemDatabase("Ham", "704311", 0.0);
  return product;
}

List<ItemDatabase> getItem() {
  return [
    product1(),
    product2() /*product3(), product4(), product5()*/
  ];

  
}

final data = [{"item":"Flour, white, all purpose, per lb.", "id":"701111", "price": 0},
{"item":"Rice, white, long grain, precooked", "id":"701311", "price": 0},
{"item":"Rice, white, long grain, uncooked, per lb.", "id":"701312", "price": 0},
{"item":"Spaghetti", "id":"701321", "price": 0},
{"item":"Spaghetti and macaroni", "id":"701322", "price": 0},
{"item":"Bread, white, pan", "id":"702111", "price": 0},
{"item":"Bread, French", "id":"702112", "price": 0},
{"item":"Bread, rye, pan", "id":"702211", "price": 0},
{"item":"Bread, whole wheat, pan", "id":"702212", "price": 0},
{"item":"Bread, wheat blend, pan", "id":"702213", "price": 0},
{"item":"Rolls, hamburger", "id":"702221", "price": 0},
{"item":"Cupcakes, chocolate", "id":"702411", "price": 0},
{"item":"Cookies, chocolate chip", "id":"702421", "price": 0},
{"item":"Crackers, soda, salted", "id":"702611", "price": 0},
{"item":"Ground chuck, 100% beef", "id":"703111", "price": 0},
{"item":"Ground beef, 100% beef", "id":"703112", "price": 0},
{"item":"Ground beef, lean and extra lean", "id":"703113", "price": 0},
{"item":"Chuck roast, USDA Choice, bone-in", "id":"703211", "price": 0},
{"item":"Chuck roast, graded and ungraded", "id":"703212", "price": 0},
{"item":"Chuck roast, USDA Choice, boneless", "id":"703213", "price": 0},
{"item":"Round roast, USDA Choice, boneless", "id":"703311", "price": 0},
{"item":"Round roast, graded and ungraded", "id":"703312", "price": 0},
{"item":"Rib roast, USDA Choice, bone-in", "id":"703411", "price": 0},
{"item":"Steak, chuck, U.S. choice, bone-in", "id":"703421", "price": 0},
{"item":"Steak, T-Bone, USDA Choice, bone-in", "id":"703422", "price": 0},
{"item":"Steak, porterhouse, U.S. choice, bone-in", "id":"703423", "price": 0},
{"item":"Steak, rib eye, USDA Choice, boneless", "id":"703425", "price": 0},
{"item":"Short ribs, any primal source, bone-in", "id":"703431", "price": 0},
{"item":"Beef for stew, boneless", "id":"703432", "price": 0},
{"item":"Steak, round, USDA Choice, boneless", "id":"703511", "price": 0},
{"item":"Steak, round, graded and ungraded", "id":"703512", "price": 0},
{"item":"Steak, sirloin, USDA Choice, bone-in", "id":"703611", "price": 0},
{"item":"Steak, sirloin, graded and ungraded", "id":"703612", "price": 0},
{"item":"Steak, sirloin, USDA Choice, boneless", "id":"703613", "price": 0},
{"item":"Bacon, sliced", "id":"704111", "price": 0},
{"item":"Chops, center cut, bone-in", "id":"704211", "price": 0},
{"item":"Chops, boneless", "id":"704212", "price": 0},
{"item":"Ham, bone-in, smoked", "id":"704311", "price": 0},
{"item":"Ham, boneless", "id":"704312", "price": 0},
{"item":"Ham, rump portion, bone-in, smoked", "id":"704313", "price": 0},
{"item":"Ham, shank portion, bone-in, smoked", "id":"704314", "price": 0},
{"item":"Ham, canned", "id":"704321", "price": 0},
{"item":"Pork shoulder roast, blade boston, bone-in", "id":"704411", "price": 0},
{"item":"Pork sirloin roast, bone-in", "id":"704412", "price": 0},
{"item":"Shoulder picnic, bone-in, smoked", "id":"704413", "price": 0},
{"item":"Sausage", "id":"704421", "price": 0},
{"item":"Frankfurters", "id":"705111", "price": 0},
{"item":"Bologna", "id":"705121", "price": 0},
{"item":"Beef liver", "id":"705141", "price": 0},
{"item":"Lamb", "id":"705142", "price": 0},
{"item":"Mutton", "id":"705142", "price": 0},
{"item":"Chicken", "id":"706111", "price": 0},
{"item":"Chicken breast", "id":"706211	", "price": 0},
{"item":"Chicken legs, bone-in", "id":"706212", "price": 0},
{"item":"Turkey", "id":"706311", "price": 0},
{"item":"Tuna, light, chunk", "id":"707111", "price": 0},
{"item":"Eggs, grade A, large", "id":"708111", "price": 0},
{"item":"Eggs, grade AA, large", "id":"708112", "price": 0},
{"item":"Milk, fresh, whole, 1/2 gal", "id":"709111", "price": 0},
{"item":"Milk, fresh, whole, 1 gal", "id":"709112", "price": 0},
{"item":"Milk, fresh, skim, 1 gal", "id":"709211", "price": 0},
{"item":"Milk, fresh, low fat, 1/2 gal.", "id":"709212", "price": 0},
{"item":"Milk, fresh, low fat, 1 gal.", "id":"709213", "price": 0},
{"item":"Butter, salted, grade AA, stick", "id":"710111", "price": 0},
{"item":"Yogurt", "id":"710122", "price": 0},
{"item":"American processed cheese", "id":"710211", "price": 0},
{"item":"Cheddar cheese", "id":"710212", "price": 0},
{"item":"Ice cream, 1/2 gal.", "id":"710411", "price": 0},
{"item":"Apples", "id":"711111", "price": 0},
{"item":"Bananas", "id":"711211", "price": 0},
{"item":"Oranges, Navel", "id":"711311", "price": 0},
{"item":"Oranges, Valencia", "id":"711312", "price": 0},
{"item":"Grapefruit", "id":"711411", "price": 0},
{"item":"Lemons", "id":"711412", "price": 0},
{"item":"Pears", "id":"711413", "price": 0},
{"item":"Peaches", "id":"711414", "price": 0},
{"item":"Strawberries", "id":"711415", "price": 0},
{"item":"Grapes, Emperor", "id":"711416", "price": 0},
{"item":"Grapes, Thompson Seedless", "id":"711417", "price": 0},
{"item":"Cherries", "id":"711418", "price": 0},
{"item":"Potatoes", "id":"712111", "price": 0},
{"item":"Lettuce, iceberg", "id":"712211", "price": 0},
{"item":"Tomatoes", "id":"712311", "price": 0},
{"item":"Cabbage", "id":"712401", "price": 0},
{"item":"Celery", "id":"712402", "price": 0},
{"item":"Carrots", "id":"712403", "price": 0},
{"item":"Onions", "id":"712404", "price": 0},
{"item":"Onions, green scallions", "id":"712405", "price": 0},
{"item":"Peppers", "id":"712406", "price": 0},
{"item":"Corn on the cob", "id":"712407", "price": 0},
{"item":"Radishes ", "id":"712408", "price": 0},
{"item":"Cucumbers", "id":"712409", "price": 0},
{"item":"Beans", "id":"712410", "price": 0},
{"item":"Mushrooms ", "id":"712411", "price": 0},
{"item":"Broccoli", "id":"712412", "price": 0},
{"item":"Orange juice", "id":"713111", "price": 0},
{"item":"Apple Sauce", "id":"713311", "price": 0},
{"item":"Potatoes, frozen, French fried", "id":"714111", "price": 0},
{"item":"Corn, canned, any style, all sizes", "id":"714221", "price": 0},
{"item":"Beans, dried", "id":"714233", "price": 0},
{"item":"Hard candy", "id":"715111", "price": 0},
{"item":"Sugar", "id":"715211", "price": 0},
{"item":"Jelly ", "id":"715311", "price": 0},
{"item":"Peanut butter", "id":"716141", "price": 0},
{"item":"Cola, 72 oz. 6 pk.", "id":"717113", "price": 0},
{"item":"Cola, 2 liters", "id":"717114", "price": 0},
{"item":"Coffee, 100%, ground roast", "id":"717311", "price": 0},
{"item":"Coffee, instant", "id":"717324", "price": 0},
{"item":"Coffee, freeze dried, regular", "id":"717325", "price": 0},
{"item":"Coffee, freeze dried, decaf.", "id":"717326", "price": 0},
{"item":"Potato chips", "id":"718311", "price": 0},
{"item":"Pork and beans, canned", "id":"718631", "price": 0},
];

getData() {
  return data;
}

databaseDynamic() async{
  DatabaseReference data = FirebaseDatabase.instance.ref("items/itemList");
  data.onValue.listen((DatabaseEvent event) { 
    final dbInfo = event.snapshot.value;
  });
}

databaseSingle() async{
  DatabaseReference data = FirebaseDatabase.instance.ref("items/itemList");
  final snapshot = await data.child("items/itemList").get();
    if (snapshot.exists){
      print(snapshot.value);
    }
  }
