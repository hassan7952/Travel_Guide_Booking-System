import 'package:flutter/material.dart';

class PlaceDetailsPage extends StatelessWidget {
  final Place place;

  PlaceDetailsPage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: place.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      place.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
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
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    place.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Culture:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    place.culture,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Hotels:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  for (var hotel in place.hotels)
                    Text(
                      hotel,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  SizedBox(height: 16.0),
                  Text(
                    'Famous Spots:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  for (var spot in place.famousSpots)
                    Text(
                      spot,
                      style: TextStyle(fontSize: 16.0),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Place {
  final String name;
  final String description;
  final String culture;
  final List<String> images;
  final List<String> hotels;
  final List<String> famousSpots;

  Place({
    required this.name,
    required this.description,
    required this.culture,
    required this.images,
    required this.hotels,
    required this.famousSpots,
  });
}

void main() {
  runApp(MaterialApp(
    home: PlaceDetailsPage(
      place: Place(
        name: 'Skardu',
        description: 'Description of Place 1',
        culture: 'Culture of Place 1',
        images: [
        //  'assets/place1_1.jpg',
        //  'assets/place1_2.jpg',
          'assets/images/skardu.jpg',
        ],
        hotels: [
          'Hotel 1',
          'Hotel 2',
          'Hotel 3',
        ],
        famousSpots: [
          'Famous Spot 1',
          'Famous Spot 2',
          'Famous Spot 3',
        ],
      ),
    ),
  ));
}
