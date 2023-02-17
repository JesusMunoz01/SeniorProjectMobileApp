class ItemDatabase {
  String name;
  String id;
  double price;

  ItemDatabase(name, id, price) {
    this.name = name;
    this.id = id;
    this.price = price;
  }
}

ItemDatabase product1() {
  ItemDatabase p1 = ItemDatabase("Flour", "1a", 2.67);
  return p1;
}

ItemDatabase product2() {
  ItemDatabase product = ItemDatabase("Ground Beef", "1b", 7.59);
  return product;
}

ItemDatabase product3() {
  ItemDatabase product = ItemDatabase("Granola Bar Pack", "1c", 5.40);
  return product;
}

ItemDatabase product4() {
  ItemDatabase product = ItemDatabase("Milk", "2a", 3.12);
  return product;
}

ItemDatabase product5() {
  ItemDatabase product = ItemDatabase("Mango", "2b", 1.52);
  return product;
}

List<ItemDatabase> getItem() {
  return [product1(), product2(), product3(), product4(), product5()];
}
