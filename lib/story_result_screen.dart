
import 'package:flutter/material.dart';

class StoryResultScreen extends StatelessWidget {
  const StoryResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Story'),
      ),
      body: const Center(
        child: Text('This is the story result screen.'),
      ),
    );
  }
}
