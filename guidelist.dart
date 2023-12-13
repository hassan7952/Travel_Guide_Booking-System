import 'package:flutter/material.dart';

class GuideProfile {
  final String name;
  final String description;
  final String imageUrl;

  GuideProfile({required this.name, required this.description, required this.imageUrl});
}

class GuideListPage extends StatelessWidget {
  final String destination;

  // Sample guide profiles for demonstration
  final List<GuideProfile> guideProfiles = [
    GuideProfile(
      name: 'Hassan',
      description: 'Experienced guide with vast knowledge of local culture and history.',
      imageUrl: 'assets/images/hassan.jpg',
    ),
    GuideProfile(
      name: 'Bob',
      description: 'Passionate guide specializing in adventure and outdoor activities.',
      imageUrl: 'assets/bob.jpg',
    ),
    // Add more guide profiles as needed
  ];

  GuideListPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guides in $destination'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: guideProfiles.length,
        itemBuilder: (context, index) {
          var guide = guideProfiles[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(guide.imageUrl),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guide.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            guide.description,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle "See Details" button click
                                  // Navigate to guide's detailed profile page
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Set button background color to black
                                ),
                                child: Text('See Details'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle "Contact Me" button click
                                  // Implement contact functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Set button background color to black
                                ),
                                child: Text('Contact Me'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GuideListPage(destination: 'Hunza Valley'), // Provide the destination name dynamically
  ));
}
