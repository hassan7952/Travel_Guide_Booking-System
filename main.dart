import 'package:flutter/material.dart';
import 'package:travelguide/login.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to the next page by 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Color chartreuseColor = Color(0xFF7FFF00); // Custom chartreuse color

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Add top padding to logo
            child: Image.asset(
              'assets/images/logo1.png', // Replace 'assets/images/logo1.png' with your logo image path
              width: 600, // Adjust the width as needed
              height: 600, // Adjust the height as needed
            ),
          ),
          SizedBox(height: 50), // Add spacing between logo and button




        ],
      ),
    );
  }
}

