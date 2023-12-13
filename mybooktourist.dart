import 'package:flutter/material.dart';

void main() {
  runApp(MyBookingTourist());
}

class Booking {
  final String placeName;
  final String date;
  final String status;
  final String guideName; // Added guideName

  Booking({
    required this.placeName,
    required this.date,
    required this.status,
    required this.guideName,
  });
}

class MyBookingTourist extends StatelessWidget {
  final List<Booking> bookings = [
    Booking(
      placeName: 'Skardu',
      date: '2023-05-15',
      status: 'Confirmed',
      guideName: 'John Doe', // Added guide name
    ),
    Booking(
      placeName: 'Naran',
      date: '2023-10-10',
      status: 'Pending',
      guideName: 'Alice Smith', // Added guide name
    ),
    // Add more sample bookings
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Bookings'),
          backgroundColor:Colors.black,

        ),
        body: ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            return BookingCard(booking: bookings[index]);
          },
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Place: ${booking.placeName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              'Guide: ${booking.guideName}', // Display guide name
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${booking.date}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${booking.status}',
              style: TextStyle(fontSize: 16, color: getStatusColor(booking.status)),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    if (status == 'Confirmed') {
      return Colors.green;
    } else if (status == 'Pending') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
