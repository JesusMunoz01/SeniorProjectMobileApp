class ItemDatabase {
  String name;
  String id;
  double price;

  ItemDatabase(name, id, price) {
    this.name = name;
    this.id = id;
    this.price = price;
  }

  setPrice(price) {
    this.price = price;
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
