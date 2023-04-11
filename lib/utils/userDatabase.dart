class UserDatabase {
  String name;
  String username;
  String uid;
  String password;
  int itemCount;
  double height;
  int age;
  double weight;
  double balance;
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
}
