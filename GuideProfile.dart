import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/GuideDBHelper.dart';

class GuideProfilePage extends StatefulWidget {
  @override
  _GuideProfilePageState createState() => _GuideProfilePageState();
}

class _GuideProfilePageState extends State<GuideProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController specializedPlacesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? _image;

  // Add this variable to track whether the profile has been updated
  bool _profileUpdated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Profile'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<Guide?>(
        // Replace with the actual phone number of the logged-in guide
        future: GuideDBHelper.instance.getGuideByPhoneNumber(""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            // Guide profile already exists, display existing information
            Guide guide = snapshot.data!;

            // Set initial values for controllers only if the profile has not been updated
            if (!_profileUpdated) {
              fullNameController.text = guide.fullName;
              cityController.text = guide.city;
              specializedPlacesController.text = guide.specializedPlaces;
              descriptionController.text = guide.description;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
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
                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextFormField(
                    controller: specializedPlacesController,
                    decoration: InputDecoration(labelText: 'Specialized Places'),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Update the existing guide profile
                      Guide updatedGuide = Guide(
                        id: guide.id,
                        fullName: fullNameController.text,
                        phoneNumber: "", // Assuming phoneNumber is required in Guide class
                        email: "", // Assuming email is required in Guide class
                        city: cityController.text,
                        password: "", // Assuming password is required in Guide class
                        specializedPlaces: specializedPlacesController.text,
                        description: descriptionController.text,
                      );

                      await GuideDBHelper.instance.updateGuide(updatedGuide);

                      // Set the profileUpdated flag to true
                      setState(() {
                        _profileUpdated = true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Guide profile updated successfully!'),
                        ),
                      );

                      // Navigate back to the previous screen
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            );
          } else {
            // Guide profile does not exist, show the form to create a new profile
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
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
                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextFormField(
                    controller: specializedPlacesController,
                    decoration: InputDecoration(labelText: 'Specialized Places'),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Create a new Guide object with the entered information
                      Guide newGuide = Guide(
                        fullName: fullNameController.text,
                        phoneNumber: "", // Assuming phoneNumber is required in Guide class
                        email: "", // Assuming email is required in Guide class
                        city: cityController.text,
                        password: "", // Assuming password is required in Guide class
                        specializedPlaces: specializedPlacesController.text,
                        description: descriptionController.text,
                      );

                      // Insert the new guide into the database
                      await GuideDBHelper.instance.insertGuide(newGuide);

                      // Set the profileUpdated flag to true
                      setState(() {
                        _profileUpdated = true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Guide profile created successfully!'),
                        ),
                      );

                      // Navigate back to the previous screen
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Create Profile'),
                  ),
                ],
              ),
            );
          }
        },
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
}
