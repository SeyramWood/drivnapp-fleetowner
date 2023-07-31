import 'package:drivn_app/screens/onboarding_screens/onboarding_screen_main.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Text("Home Page"),
      // ),
      resizeToAvoidBottomInset: false,

      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/getting_started_bg_image.png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your content here
              Padding(
                padding: EdgeInsets.only(bottom: 300),
                // padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Find your rental cars easily',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Add your button action here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                  );
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(343, 54),
                  ), // Adjust the size as needed
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF554AF0),
                  ), // Change the background color here
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
