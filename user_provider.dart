import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  // This is a simplified version; you might need to adjust it based on your actual implementation.
  UserProfile userProfile = UserProfile(
    fullName: 'John Doe',
    city: 'Example City',
    email: 'john.doe@example.com',
    contactNumber: '1234567890',
  );

  UserProfile getUserProfile() {
    return userProfile;
  }

// Add methods to update or retrieve user profile as needed
}

class UserProfile {
  final String fullName;
  final String city;
  final String email;
  final String contactNumber;

  UserProfile({
    required this.fullName,
    required this.city,
    required this.email,
    required this.contactNumber,
  });
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use context.watch to get the UserProvider instance
    var userProvider = context.watch<UserProvider>();

    // Fetch user details
    UserProfile userProfile = userProvider.getUserProfile();

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProfile.fullName}'),
            Text('City: ${userProfile.city}'),
            Text('Email: ${userProfile.email}'),
            Text('Contact Number: ${userProfile.contactNumber}'),
            // Add other profile information as needed

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // Navigate to the UpdateProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                );
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add form fields for updating profile information
            TextField(
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // Perform the update logic here

                // After updating, you might want to pop the page or navigate back
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        home: UserProfilePage(),
      ),
    ),
  );
}
