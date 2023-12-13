// GuideDBHelper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:travelguide/request.dart';

class Guide {
  final int? id;
  late final String fullName;
  final String phoneNumber;
  final String email;
  late final String city;
  final String password;
  late final String specializedPlaces;
  late final String description;

  Guide({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.password,
    required this.specializedPlaces,
    required this.description,
  });

  set imagePath(String imagePath) {}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'city': city,
      'password': password,
      'specializedPlaces': specializedPlaces,
      'description': description,
    };
  }

  factory Guide.fromMap(Map<String, dynamic> map) {
    return Guide(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      city: map['city'],
      password: map['password'],
      specializedPlaces: map['specializedPlaces'],
      description: map['description'],
    );
  }
}

class GuideDBHelper {
  GuideDBHelper._(); // private constructor to prevent instantiation

  static final GuideDBHelper instance = GuideDBHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'guide_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE guides (
            id INTEGER PRIMARY KEY,
            fullName TEXT,
            phoneNumber TEXT,
            email TEXT,
            city TEXT,
            password TEXT,
            specializedPlaces TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertGuide(Guide guide) async {
    final db = await database;

    // Check if the account with the given phone number or email already exists
    Guide? existingGuide = await getGuideByPhoneNumber(guide.phoneNumber);
    if (existingGuide != null) {
      throw Exception('Account with this phone number already exists');
    }

    existingGuide = await getGuideByEmail(guide.email);
    if (existingGuide != null) {
      throw Exception('Account with this email already exists');
    }

    // If no existing account, proceed with insertion
    await db.insert('guides', guide.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Guide>> getAllGuides() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('guides');

    return List.generate(maps.length, (i) {
      return Guide(
        id: maps[i]['id'],
        fullName: maps[i]['fullName'],
        phoneNumber: maps[i]['phoneNumber'],
        email: maps[i]['email'],
        city: maps[i]['city'],
        password: maps[i]['password'],
        specializedPlaces: maps[i]['specializedPlaces'],
        description: maps[i]['description'],
      );
    });
  }

  Future<Guide?> getGuideByPhoneNumber(String phoneNumber) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'guides',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );

    if (maps.isNotEmpty) {
      return Guide.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Guide?> getGuideByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'guides',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return Guide.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Guide?> loginGuide(String phoneNumber, String password) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'guides',
      where: 'phoneNumber = ? AND password = ?',
      whereArgs: [phoneNumber, password],
    );

    if (maps.isNotEmpty) {
      return Guide.fromMap(maps.first);
    } else {
      return null;
    }
  }

  

  Future<List<Guide>> getGuidesByName(String guideName) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'guides',
      where: 'fullName LIKE ?',
      whereArgs: ['%$guideName%'],
    );

    return List.generate(maps.length, (i) {
      return Guide(
        id: maps[i]['id'],
        fullName: maps[i]['fullName'],
        phoneNumber: maps[i]['phoneNumber'],
        email: maps[i]['email'],
        city: maps[i]['city'],
        password: maps[i]['password'],
        specializedPlaces: maps[i]['specializedPlaces'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> updateGuide(Guide updatedGuide) async {
    final db = await database;
    await db.update(
      'guides',
      updatedGuide.toMap(),
      where: 'id = ?',
      whereArgs: [updatedGuide.id],
    );
  }
  Future<List<Guide>> getGuidesBySpecializedPlaces(String query, {required String language, required String guideType, required List<String> languages}) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'guides',
      where: 'specializedPlaces LIKE ?',
      whereArgs: ['%$query%'],
    );

    return List.generate(maps.length, (i) {
      return Guide(
        id: maps[i]['id'],
        fullName: maps[i]['fullName'],
        phoneNumber: maps[i]['phoneNumber'],
        email: maps[i]['email'],
        city: maps[i]['city'],
        password: maps[i]['password'],
        specializedPlaces: maps[i]['specializedPlaces'],
        description: maps[i]['description'],
      );
    });
  }

  }
  Future<Guide?> getGuideById(int guideId) async {
    var database;
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'guides',
      where: 'id = ?',
      whereArgs: [guideId],
    );

    if (maps.isNotEmpty) {
      return Guide.fromMap(maps.first);
    } else {
      return null;
    }
  }







