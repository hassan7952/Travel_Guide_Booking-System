import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travelguide/Complain.dart';
import 'package:travelguide/GuideMenu.dart';
import 'package:travelguide/Guidemybookings.dart';
import 'package:travelguide/bookguide.dart';
import 'package:travelguide/hotels.dart';
import 'package:travelguide/menu.dart';
import 'package:travelguide/request.dart';
import 'package:travelguide/viewplaces.dart';

void main() {
  runApp(MaterialApp(
    home: GuideHomePage(),
  ));
}

class GuideHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GuideHomePage> {
  final List<String> imageList = [
    'assets/images/pic1.jpg',
    'assets/images/peakpx.jpg',
    // Add more image paths here
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TourGuide'),
        backgroundColor: Colors.black, // Hex code for chartreuse color
        // Set Appbar color to Chartreuse
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white, // Set icon color to white
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GuideMenuPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: imageList.map((imagePath) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                autoPlayInterval: Duration(milliseconds: 1500),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.map((url) {
                int index = imageList.indexOf(url);
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.teal : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeatureButton(Icons.book, 'View Requests', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>GuideRequestPage()),

                  );


                }),
                buildFeatureButton(Icons.place, 'Places', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VisitPlacesPage()),
                  );
                }),
                buildFeatureButton(Icons.hotel, 'Hotels', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Hotels()),
                  );
                }),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeatureButton(Icons.bookmark, 'My Bookings', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideBookings()),
                  );
                }),
                //buildFeatureButton(Icons.monetization_on, 'Refund', () {
                  // Add your code for Refund button
                //}),
                buildFeatureButton(Icons.message, 'Complain', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintForm()),
                  );

                  // Add your code for Complain button
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureButton(IconData icon, String label, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black, // Set background color to black
            child: IconButton(
              icon: Icon(
                icon,
                size: 30,
                color: Colors.white, // Set icon color to white
              ),
              onPressed: onPressed,
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
