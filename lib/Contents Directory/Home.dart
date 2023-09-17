import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double appUsagePercentage = 0.0; // Initialize the percentage (20%)

  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Start a timer to periodically update the percentage
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      updatePercentage();
    });
  }

  // Function to update the appUsagePercentage
  void updatePercentage() {
    setState(() {
      // Simulate an increase in usage, update the percentage accordingly
      appUsagePercentage += 0.01;
      if (appUsagePercentage > 1.0) {
        appUsagePercentage = 1.0; // Cap the percentage at 100%
      }
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade200,
              Colors.blue.shade200,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Your Learning Journey!!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black, // Text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Add spacing
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8), // Set the container color to black with opacity
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CircularPercentIndicator(
                    radius: 100,
                    circularStrokeCap: CircularStrokeCap.round,
                    lineWidth: 10,
                    progressColor: Colors.blue.shade500, // Set the progress color to blue
                    backgroundColor: Colors.black.withOpacity(0.5), // Adjust opacity
                    percent: appUsagePercentage,
                    center: Text(
                      '${(appUsagePercentage * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
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
