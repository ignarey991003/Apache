import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/product.dart';

class StatsScreen extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Estadísticas")),
      body: FutureBuilder<List<Product>>(
        future: dbHelper.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Product> products = snapshot.data;

          double totalInvested = products.fold(0, (sum, p) => sum + p.invested);
          double totalRevenue = products.fold(0, (sum, p) => sum + (p.price * p.quantity));
          double totalGain = totalRevenue - totalInvested;
          double gainPercent = (totalGain / totalInvested) * 100;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dinero invertido: \$${totalInvested.toStringAsFixed(2)}"),
                Text("Ingresos estimados: \$${totalRevenue.toStringAsFixed(2)}"),
                Text("Ganancia: \$${totalGain.toStringAsFixed(2)}"),
                Text("Porcentaje de ganancia: ${gainPercent.toStringAsFixed(2)}%"),
              ],
            ),
          );
        },
      ),
    );
  }
}

