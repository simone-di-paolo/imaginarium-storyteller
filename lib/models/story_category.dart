import 'package:flutter/material.dart';

class StoryCategory {
  final String id;
  final String name;
  final String icon;
  final Gradient gradient;

  const StoryCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.gradient,
  });
}

final List<StoryCategory> storyCategories = [
  const StoryCategory(
    id: 'adventure',
    name: 'Adventure',
    icon: '🗺️',
    gradient: LinearGradient(
      colors: [Color(0xFFFFA726), Color(0xFFF4511E)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const StoryCategory(
    id: 'fantasy',
    name: 'Fantasy',
    icon: '🐉',
    gradient: LinearGradient(
      colors: [Color(0xFFAB47BC), Color(0xFFEC407A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const StoryCategory(
    id: 'space',
    name: 'Space',
    icon: '🚀',
    gradient: LinearGradient(
      colors: [Color(0xFF42A5F5), Color(0xFF5C6BC0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
    const StoryCategory(
    id: 'animals',
    name: 'Animals',
    icon: '🦁',
    gradient: LinearGradient(
      colors: [Color(0xFF66BB6A), Color(0xFF26A69A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const StoryCategory(
    id: 'friendship',
    name: 'Friendship',
    icon: '🤝',
    gradient: LinearGradient(
      colors: [Color(0xFFEC407A), Color(0xFFF06292)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  const StoryCategory(
    id: 'mystery',
    name: 'Mystery',
    icon: '🔍',
    gradient: LinearGradient(
      colors: [Color(0xFF78909C), Color(0xFF546E7A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];
