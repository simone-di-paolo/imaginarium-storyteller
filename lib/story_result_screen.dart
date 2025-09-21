
import 'package:flutter/material.dart';

class StoryResultScreen extends StatelessWidget {
  const StoryResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Magical Story'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Generating your story...'),
          ],
        ),
      ),
    );
  }
}
