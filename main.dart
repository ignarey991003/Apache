import 'package:flutter/material.dart';
import 'screens/inventory_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/stats_screen.dart';

void main() {
  runApp(CafeteriaApp());
}

class CafeteriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafetería Estrella',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cafetería Estrella')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Inventario'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => InventoryScreen())),
            ),
            ElevatedButton(
              child: Text('Ventas'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SalesScreen())),
            ),
            ElevatedButton(
              child: Text('Estadísticas'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => StatsScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

