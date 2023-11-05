import 'package:flutter/material.dart';
import 'calculator_screen.dart'; // Import the 'calculator_screen.dart' file which contains your CalculatorScreen widget.

void main() {
  runApp(const MyApp()); // Start the Flutter application by running the MyApp widget.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for the MyApp class. 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner in the top-right corner.
      title: 'Calculator', // Set the title of the app.
      theme: ThemeData.dark(), // Set the app's theme to dark mode.
      home: const CalculatorScreen(), // Set the CalculatorScreen widget as the initial screen of the app.
    );
  }
}
