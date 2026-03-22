import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'cafeteria.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          quantity INTEGER,
          cost REAL,
          price REAL
        )
      ''');
    });
  }

  Future<int> insertProduct(Product product) async {
    var client = await db;
    return await client.insert('products', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    var client = await db;
    List<Map<String, dynamic>> maps = await client.query('products');
    return maps.map((p) => Product(
      id: p['id'],
      name: p['name'],
      quantity: p['quantity'],
      cost: p['cost'],
      price: p['price'],
    )).toList();
  }
}

