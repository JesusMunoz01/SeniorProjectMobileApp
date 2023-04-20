class UserDatabase {
  String name;
  String username;
  String uid;
  String password;
  int itemCount;
  int age;
  double weight;
  double height;
  double budget;
  double spent = 0;
  bool isLogged = false;
  bool hasFavs = false;
  Set<String> favItems = Set<String>();
  List<int> counters = new List<int>.generate(200, (index) => 0);

  StoreId(String item){
    favItems.add(item);
  }
  GetId(){
    return favItems;
  }

  AddCount(index, number){
    counters[index] = counters[index] + number;
  }

  GetCount(index){
    return counters[index];
  }

  clearVal(){
    counters.setAll(0, List<int>.generate(200, (index) => 0));
  }

  changeSpent(price){
    spent += price;
  }
}
