import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(Hotels());
}

class Hotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HotelList(),
    );
  }
}

class Hotel {
  final String name;
  final String location;
  final double priceUSD;
  final String image;

  Hotel({
    required this.name,
    required this.location,
    required this.priceUSD,
    required this.image,
  });

  double get pricePKR => convertUsdToPkr(priceUSD);
}

// Define a currency conversion rate (for example, 1 USD to PKR).
double usdToPkrRate = 300.0;

// Function to convert USD to PKR.
double convertUsdToPkr(double usd) {
  return usd * usdToPkrRate;
}

class HotelList extends StatelessWidget {
  final List<Hotel> hotels = [
    Hotel(
      name: 'Hotel Northern Lights',
      location: 'Hunza Valley',
      priceUSD: 150,
      image: 'assets/images/hunzahotel.jpg',
    ),
    Hotel(
      name: 'Snowy Peaks Resort',
      location: 'Naran',
      priceUSD: 120,
      image: 'assets/images/Naranhotel.jpg',
    ),
    Hotel(
      name: 'Shangrila Resort',
      location: 'Skardu',
      priceUSD: 200,
      image: 'assets/images/Skarduhotel.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return HotelCard(hotel: hotels[index]);
        },
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Image.asset(
            hotel.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(hotel.name),
            subtitle: Text(hotel.location),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                Text(
                  '₨${hotel.pricePKR.toStringAsFixed(2)} / night',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the booking logic here.
              // You can navigate to a booking page or perform any other actions.
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text('Book Now', style: TextStyle(color: Colors.white)),
          ),

        ],
      ),
    );
  }
}
