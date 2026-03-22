import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/product.dart';
import '../models/sale.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final dbHelper = DatabaseHelper();
  Product selectedProduct;
  int quantity = 1;
  bool applyTenPercent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar Venta")),
      body: FutureBuilder<List<Product>>(
        future: dbHelper.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Product> products = snapshot.data;
          return Column(
            children: [
              DropdownButton<Product>(
                hint: Text("Selecciona producto"),
                value: selectedProduct,
                items: products.map((p) {
                  return DropdownMenuItem(value: p, child: Text(p.name));
                }).toList(),
                onChanged: (p) => setState(() => selectedProduct = p),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Cantidad"),
                keyboardType: TextInputType.number,
                onChanged: (val) => quantity = int.tryParse(val) ?? 1,
              ),
              SwitchListTile(
                title: Text("Aplicar +10% precio"),
                value: applyTenPercent,
                onChanged: (val) => setState(() => applyTenPercent = val),
              ),
              ElevatedButton(
                child: Text("Registrar Venta"),
                onPressed: () async {
                  if (selectedProduct == null) return;
                  double finalPrice = applyTenPercent
                      ? selectedProduct.price * 1.1
                      : selectedProduct.price;
                  Sale sale = Sale(
                    productId: selectedProduct.id,
                    quantity: quantity,
                    price: finalPrice,
                  );
                  // Aquí guardarías la venta en la BD
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Venta registrada: ${sale.total}")),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}

