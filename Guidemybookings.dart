import 'package:flutter/material.dart';

void main() {
  runApp(GuideBookings());
}

class GuideBookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyBookingsPage(),
    );
  }
}

class Booking {
  final String name;
  final String date;
  final bool isConfirmed;

  Booking({
    required this.name,
    required this.date,
    required this.isConfirmed,
  });
}

class MyBookingsPage extends StatelessWidget {
  final List<Booking> bookings = [
    Booking(name: 'Client A', date: '2023-11-01', isConfirmed: true),
    Booking(name: 'Client B', date: '2023-11-10', isConfirmed: true),
    Booking(name: 'Client C', date: '2023-12-05', isConfirmed: false),
    Booking(name: 'Client D', date: '2023-12-20', isConfirmed: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          BookingList(title: 'Confirmed Bookings', isConfirmed: true),
          BookingList(title: 'Pending Bookings', isConfirmed: false),
        ],
      ),
    );
  }
}

class BookingList extends StatelessWidget {
  final String title;
  final bool isConfirmed;

  BookingList({
    required this.title,
    required this.isConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    final filteredBookings = MyBookingsPage().bookings
        .where((booking) => booking.isConfirmed == isConfirmed)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: filteredBookings.length,
          itemBuilder: (context, index) {
            return BookingCard(booking: filteredBookings[index]);
          },
        ),
      ],
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  BookingCard({
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(' ${booking.name}'),
        subtitle: Text('Date: ${booking.date}'),
      ),
    );
  }
}
