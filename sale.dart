class Sale {
  int id;
  int productId;
  int quantity;
  double price;

  Sale({this.id, this.productId, this.quantity, this.price});

  double get total => quantity * price;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}

