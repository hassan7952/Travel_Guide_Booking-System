import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travelguide/Complain.dart';
import 'package:travelguide/bookguide.dart';
import 'package:travelguide/hotels.dart';
import 'package:travelguide/menu.dart';
import 'package:travelguide/mybooktourist.dart';
import 'package:travelguide/viewplaces.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageList = [
    'assets/images/skardu.jpg',
    'assets/images/chitral.jpg',
    'assets/images/naraan.jpg',
    // Add more image paths here
  ];

  int _current = 0;

  List<String> recommendedPlaces = [
    'Skardu',
    'Chitral',
    'Naran',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TourGuide'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
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
                buildFeatureButton(Icons.book, 'Book Guide', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bookguide()),
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
                buildFeatureButton(Icons.bookmark, 'My Booking', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBookingTourist()),
                  );
                  // Add your code for My Booking button
                }),
                buildFeatureButton(Icons.monetization_on, 'Refund', () {
                  // Add your code for Refund button
                }),
                buildFeatureButton(Icons.message, 'Complain', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintForm()),
                  );
                  // Add your code for Complain button
                }),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Places',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedPlaces.length,
                itemBuilder: (context, index) {
                  return buildRecommendedPlaceCard(recommendedPlaces[index]);
                },
              ),
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
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                icon,
                size: 30,
                color: Colors.white,
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

  Widget buildRecommendedPlaceCard(String placeName) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 150,
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
               'assets/images/skardu.jpg',// Example image path
              width: 150,
              height: 135,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                placeName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
