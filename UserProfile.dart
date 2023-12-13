import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserProfile {
  final int? id;
  final String name;
  final String city;
  final String contactNumber;
  final String? profilePicture;

  UserProfile({
    this.id,
    required this.name,
    required this.city,
    required this.contactNumber,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'contactNumber': contactNumber,
      'profilePicture': profilePicture,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      contactNumber: map['contactNumber'],
      profilePicture: map['profilePicture'],
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  File? _image;
  bool isEditing = false;
  late UserProfile _userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.grey,
                )
                    : null,
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: contactNumberController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await saveProfile();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile saved successfully!'),
                  ),
                );
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('Save Profile'),
            ),
            if (isEditing)
              ElevatedButton(
                onPressed: () async {
                  await updateProfile();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile updated successfully!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('Update Profile'),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> saveProfile() async {
    final profile = UserProfile(
      name: nameController.text,
      city: cityController.text,
      contactNumber: contactNumberController.text,
      profilePicture: _image?.path,
    );

    await insertProfile(profile);
    setState(() {
      isEditing = true;
      _userProfile = profile;
    });
  }

  Future<void> updateProfile() async {
    final profile = UserProfile(
      id: _userProfile.id,
      name: nameController.text,
      city: cityController.text,
      contactNumber: contactNumberController.text,
      profilePicture: _image?.path,
    );

    await updateProfileById(profile);
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'user_profiles.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user_profiles (
            id INTEGER PRIMARY KEY,
            name TEXT,
            city TEXT,
            contactNumber TEXT,
            profilePicture TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertProfile(UserProfile profile) async {
    final db = await initDatabase();
    await db.insert('user_profiles', profile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    clearControllers();
  }

  Future<void> updateProfileById(UserProfile profile) async {
    final db = await initDatabase();
    await db.update(
      'user_profiles',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );

    clearControllers();
  }

  void clearControllers() {
    nameController.clear();
    cityController.clear();
    contactNumberController.clear();
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfilePage(),
  ));
}
