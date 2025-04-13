import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// Singleton pattern to ensure only one instance of the database helper exists
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('app.db');
    return _database!;
  }

  /// Initialize the database and create the necessary tables
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Handle database creation
  Future _onCreate(Database db, int version) async {
    await _createTables(db);
    await _insertDummyData(db);
  }

  /// Create the database tables
  Future _createTables(Database db) async {
    // Create the `users` table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nik TEXT NOT NULL,
        name TEXT NOT NULL,
        password TEXT NOT NULL,
        birthPlace TEXT NOT NULL,
        birthDate TEXT NOT NULL,
        gender TEXT,
        job TEXT,
        weightKg INTEGER,
        heightCm INTEGER,
        bloodType TEXT,
        address TEXT,
        rt INTEGER,
        rw INTEGER,
        village TEXT,
        district TEXT,
        city TEXT,
        province TEXT
      )
    ''');

    // Create the `locations` table
    await db.execute('''
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL
      )
    ''');

    // Create the `appointments` table
    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        location_id INTEGER NOT NULL,
        time TEXT NOT NULL,
        status INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE CASCADE
      )
    ''');
  }

  /// Insert dummy data into the database
  Future _insertDummyData(Database db) async {
    await db.insert('locations', {
      'name': 'Central Jakarta Blood Donation Center',
      'latitude': -6.186486,
      'longitude': 106.834091,
      'start_time': '08:00',
      'end_time': '17:00',
    });

    await db.insert('locations', {
      'name': 'South Jakarta Blood Donation Center',
      'latitude': -6.261493,
      'longitude': 106.810722,
      'start_time': '09:00',
      'end_time': '18:00',
    });

    await db.insert('locations', {
      'name': 'West Jakarta Blood Donation Center',
      'latitude': -6.168329,
      'longitude': 106.758423,
      'start_time': '07:30',
      'end_time': '16:30',
    });

    await db.insert('locations', {
      'name': 'East Jakarta Blood Donation Center',
      'latitude': -6.225014,
      'longitude': 106.900447,
      'start_time': '08:30',
      'end_time': '17:30',
    });

    await db.insert('locations', {
      'name': 'North Jakarta Blood Donation Center',
      'latitude': -6.121435,
      'longitude': 106.774124,
      'start_time': '09:00',
      'end_time': '18:00',
    });
  }

  /// Clear the database by deleting the database file
  Future<void> clearDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    // Close the database if it's open
    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    // Delete the database file
    await deleteDatabase(path);
  }

  /// Close the database connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
