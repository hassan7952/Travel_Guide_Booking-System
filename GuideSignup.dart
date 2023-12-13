import 'package:flutter/material.dart';
import 'package:travelguide/GuideLogin.dart';
import 'package:travelguide/login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Guide {
  final int? id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String city;
  final String password;
  final String specializedPlaces;
  final String description;

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

  getGuideByPhoneNumber(String phoneNumber) {}

  loginGuide(String phoneNumber, String password) {}
}

class GuideSignupPage extends StatefulWidget {
  @override
  _GuideSignupPageState createState() => _GuideSignupPageState();
}

class _GuideSignupPageState extends State<GuideSignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController specializedPlacesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Image.asset(
                  'assets/images/logo1.png',
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name *',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number *',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (value.length < 11) {
                      return 'Phone number should be at least 11 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email *',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City *',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password *',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: specializedPlacesController,
                  decoration: InputDecoration(
                    labelText: 'Specialized Places *',
                    prefixIcon: Icon(Icons.place),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your specialized places';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description *',
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Form fields are valid, proceed with database operations

                      // Create a Guide object from the form data
                      Guide newGuide = Guide(
                        fullName: fullNameController.text,
                        phoneNumber: phoneNumberController.text,
                        email: emailController.text,
                        city: cityController.text,
                        password: passwordController.text,
                        specializedPlaces: specializedPlacesController.text,
                        description: descriptionController.text,
                      );

                      // Insert the guide into the database
                      await GuideDBHelper.instance.insertGuide(newGuide);

                      // Navigate to the login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GuideLoginPage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GuideSignupPage(),
  ));
}
