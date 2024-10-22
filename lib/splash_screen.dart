import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for heart beat effect
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400), // Duration for one beat
      lowerBound: 0.9, // Minimal scaling (shrink)
      upperBound: 1.1, // Maximal scaling (grow)
    )..repeat(reverse: true); // Repeat the animation with reverse

    // Navigate to the HomeScreen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      _controller.stop();  // Stop the animation when transitioning
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 239, 239),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center everything vertically
          children: [
            // Apply the heart beat animation using ScaleTransition
            ScaleTransition(
              scale: _controller,
              child: Image.asset(
                'assets/images/heart.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'BMI Calculator',
              style: TextStyle(
                fontSize: 32,
                color: const Color.fromARGB(255, 133, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
