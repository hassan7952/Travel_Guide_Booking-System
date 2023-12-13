import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ComplaintForm(),
    theme: ThemeData(
      primarySwatch: Colors.green, // Change the primary color to green
    ),
  ));
}

class ComplaintForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bookingNumberController = TextEditingController();
  final TextEditingController _detailIssueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Form'),
        backgroundColor: Colors.green, // Set the background color to green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bookingNumberController,
                decoration: InputDecoration(labelText: 'Booking Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your booking number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _detailIssueController,
                decoration: InputDecoration(labelText: 'Detail Issue'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide details of your issue';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, handle the complaint submission here
                String name = _nameController.text;
                String email = _emailController.text;
                String bookingNumber = _bookingNumberController.text;
                String detailIssue = _detailIssueController.text;

                // Process the complaint data as needed
                // For example, send it to a server or store it locally

                // Display a success message
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Complaint submitted successfully!'),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Set the button's background color to green
            ),
            child: Text(
              'Submit Complaint',
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
            ),
          ),


            ],
          ),
        ),
      ),
    );
  }
}
