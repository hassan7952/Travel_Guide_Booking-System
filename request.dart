import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guide Request Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GuideRequestPage(),
    );
  }
}

class GuideRequestPage extends StatefulWidget {
  @override
  _GuideRequestPageState createState() => _GuideRequestPageState();
}

class _GuideRequestPageState extends State<GuideRequestPage> {
  List<Map<String, dynamic>> requests = [
    {
      'user': 'John Doe',
      'location': 'Naran',
      'date': '2022-07-15',
    },
    // Add more mock request data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Requests'),

      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                requests[index]['user'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Location: ${requests[index]['location']}\nDate: ${requests[index]['date']}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle accept request logic
                      print('Request Accepted');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.blue),
                    onPressed: () {
                      // Handle contact user logic
                      print('Contact User');
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
