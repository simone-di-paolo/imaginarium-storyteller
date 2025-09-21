
import 'package:flutter/material.dart';

class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a New Story'),
      ),
      body: const Center(
        child: Text('This is the create story screen.'),
      ),
    );
  }
}
