import 'package:flutter/material.dart';

class VisitPlacesPage extends StatelessWidget {
  final List<Place> places = [
    Place(
      name: 'Skardu',
      description: 'Skardu, along with Gilgit, is a major tourism, trekking and expedition hub in Gilgit–Baltistan...',
      image: 'assets/images/skardu.jpg',
    ),
    Place(
      name: 'Chitral',
      description: 'Chitral District (Urdu: ضِلع چترال) was the largest district in the Khyber-Pakhtunkhwa province of Pakistan...',
      image: 'assets/images/chitral.jpg',
    ),
    Place(
      name: 'Naran',
      description: 'Naran is a town and popular tourist destination in upper Kaghan Valley in the Mansehra District of the Khyber Pakhtunkhwa province of Pakistan...',
      image: 'assets/images/naraan.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visit Places'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return PlaceCard(place: places[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Place {
  final String name;
  final String description;
  final String image;

  Place({
    required this.name,
    required this.description,
    required this.image,
  });
}

class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  place.description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your code for exploring the place
                  },
                  child: Text('Explore'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VisitPlacesPage(),
  ));
}
