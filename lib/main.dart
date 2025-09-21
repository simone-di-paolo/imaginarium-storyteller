
import 'package:flutter/material.dart';
import 'package:myapp/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Imaginarium Storyteller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue, // Color for the selected icon
          unselectedItemColor: Colors.grey, // Color for unselected icons
          backgroundColor: Colors.white, // Background color of the bar
        ),
      ),
    );
  }
}
