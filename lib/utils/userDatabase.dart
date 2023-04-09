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

  StoreId(String item){
    favItems.add(item);
  }
  GetId(){
    return favItems;
  }
}
