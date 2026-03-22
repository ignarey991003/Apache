class Product {
  int id;
  String name;
  int quantity;
  double cost;
  double price;

  Product({this.id, this.name, this.quantity, this.cost, this.price});

  double get invested => cost * quantity;
  double get gainPercent => ((price - cost) / cost) * 100;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'cost': cost,
      'price': price,
    };
  }
}

