import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bookguide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController locationController = TextEditingController();
  List<String> availableLanguages = ['English', 'Urdu', 'Punjabi', 'Pashto'];
  List<String> selectedLanguages = [];
  String selectedPreference = 'Family';

  List<Map<String, dynamic>> recommendations = [];

  Future<void> fetchData() async {
    // Validate if the location is not empty
    if (locationController.text.isEmpty) {
      // Show an error message or handle it as per your requirement
      print('Location is required.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/recommend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'location': locationController.text,
          'languages': selectedLanguages.join(','), // Join selected languages
          'preference': selectedPreference,
        }),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
        List<Map<String, dynamic>>.from(json.decode(response.body));

        print('Received data: $responseData');

        setState(() {
          recommendations = responseData;
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error during data fetching: $error');
    }
  }

  void bookGuide(int index) {
    // Implement your logic for booking the guide
    print('Book Guide ${recommendations[index]['Name']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Guide Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.book, color: Colors.white),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Enter Location'),
            ),
            SizedBox(height: 10),
            Wrap(
              children: availableLanguages.map((language) {
                return FilterChip(
                  label: Text(language),
                  selected: selectedLanguages.contains(language),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedLanguages.add(language);
                      } else {
                        selectedLanguages.remove(language);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Preference'),
              value: selectedPreference,
              onChanged: (String? value) {
                setState(() {
                  selectedPreference = value ?? '';
                });
              },
              items: ['Family', 'Solo'].map((preference) {
                return DropdownMenuItem(
                  value: preference,
                  child: Text(preference),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Search Guides'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final guide = recommendations[index];
                  return ListTile(
                    title: Text(guide['Name'] ?? 'Unknown'),
                    subtitle: Text(guide['Description'] ?? 'No description available'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        bookGuide(index);
                      },
                      child: Text('Book Guide'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
