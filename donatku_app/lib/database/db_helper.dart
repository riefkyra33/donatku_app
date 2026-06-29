import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'donatku_role.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            email TEXT UNIQUE,
            password TEXT,
            role TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE produk (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_produk TEXT,
            harga INTEGER,
            stok INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE pesanan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_pelanggan TEXT,
            email_member TEXT,
            nama_produk TEXT,
            jumlah INTEGER,
            total_harga INTEGER,
            tanggal TEXT
          )
        ''');

        await db.insert('users', {
          'nama': 'Admin',
          'email': 'admin@gmail.com',
          'password': 'admin123',
          'role': 'admin',
        });

        await db.insert('produk', {
          'nama_produk': 'Donat Coklat',
          'harga': 5000,
          'stok': 20,
        });

        await db.insert('produk', {
          'nama_produk': 'Donat Keju',
          'harga': 6000,
          'stok': 15,
        });

        await db.insert('produk', {
          'nama_produk': 'Donat Stroberi',
          'harga': 5500,
          'stok': 18,
        });
      },
    );
  }

  static Future<int> registerUser(
    String nama,
    String email,
    String password,
  ) async {
    final db = await database;
    return await db.insert('users', {
      'nama': nama,
      'email': email,
      'password': password,
      'role': 'member',
    });
  }

  static Future<Map<String, dynamic>?> loginUser(
    String email,
    String password,
  ) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> tambahProduk(
    String namaProduk,
    int harga,
    int stok,
  ) async {
    final db = await database;
    return await db.insert('produk', {
      'nama_produk': namaProduk,
      'harga': harga,
      'stok': stok,
    });
  }

  static Future<List<Map<String, dynamic>>> getProduk() async {
    final db = await database;
    return await db.query('produk', orderBy: 'id DESC');
  }

  static Future<int> updateProduk(
    int id,
    String namaProduk,
    int harga,
    int stok,
  ) async {
    final db = await database;
    return await db.update(
      'produk',
      {
        'nama_produk': namaProduk,
        'harga': harga,
        'stok': stok,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> hapusProduk(int id) async {
    final db = await database;
    return await db.delete(
      'produk',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> tambahPesanan(
    String namaPelanggan,
    String emailMember,
    String namaProduk,
    int jumlah,
    int totalHarga,
    String tanggal,
  ) async {
    final db = await database;
    return await db.insert('pesanan', {
      'nama_pelanggan': namaPelanggan,
      'email_member': emailMember,
      'nama_produk': namaProduk,
      'jumlah': jumlah,
      'total_harga': totalHarga,
      'tanggal': tanggal,
    });
  }

  static Future<List<Map<String, dynamic>>> getSemuaPesanan() async {
    final db = await database;
    return await db.query('pesanan', orderBy: 'id DESC');
  }

  static Future<List<Map<String, dynamic>>> getPesananByMember(
    String emailMember,
  ) async {
    final db = await database;
    return await db.query(
      'pesanan',
      where: 'email_member = ?',
      whereArgs: [emailMember],
      orderBy: 'id DESC',
    );
  }

  static Future<int> hapusPesanan(int id) async {
    final db = await database;
    return await db.delete(
      'pesanan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}