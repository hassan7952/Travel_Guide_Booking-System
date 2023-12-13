import 'package:flutter/material.dart';
import 'package:travelguide/GuideSignup.dart';
import 'package:travelguide/Guidehomepage.dart';



class GuideLoginPage extends StatefulWidget {
  @override
  _GuideLoginPageState createState() => _GuideLoginPageState();
}

class _GuideLoginPageState extends State<GuideLoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logo1.png',
                width: 250,
                height: 250,
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Add your code for forgot password functionality
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  // Validate login credentials using the guide signup database
                  bool isValid = await validateGuideLogin(
                    phoneNumberController.text,
                    passwordController.text,
                  );

                  if (isValid) {
                    // Navigate to the guide home page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GuideHomePage()),
                    );
                  } else {
                    // Show an error message or handle invalid login
                    // For example, you can show a snackbar
                    showSnackBar(context, 'Invalid credentials. Please try again.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GuideSignupPage()),
                  );
                },
                child: Text(
                  'Sign up ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> validateGuideLogin(String phoneNumber, String password) async {
    // Perform validation using the guide signup database
    // You can query the database and check if the provided credentials are valid
    // For simplicity, I'm assuming a synchronous validation here
    // You may need to adjust this based on your actual database implementation
    // (e.g., using async/await with database queries)
    Guide? guide = await GuideDBHelper.instance.loginGuide(phoneNumber, password);

    if (guide != null) {
      return true; // Valid login
    } else {
      return false; // Invalid login
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GuideLoginPage(),
  ));
}


