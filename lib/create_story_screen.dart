
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'models/story_category.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  int _currentStep = 1;
  final int _totalSteps = 4;
  String? _selectedCategoryId;

  Map<String, dynamic> _prompts = {};
  Map<String, String> _selectedWords = {};

  final _childNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _favoriteAnimalController = TextEditingController();
  final _settingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPrompts();
  }

  Future<void> _loadPrompts() async {
    final String response = await rootBundle.loadString('assets/prompts.json');
    final data = await json.decode(response);
    setState(() {
      _prompts = data;
    });
  }

  @override
  void dispose() {
    _childNameController.dispose();
    _ageController.dispose();
    _favoriteAnimalController.dispose();
    _settingController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
    });
  }

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      if (_currentStep == 1 && _selectedCategoryId != null) {
        _initializeSelectedWords();
      }
      setState(() {
        _currentStep++;
      });
    } else {
      context.go('/home/story');
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      context.pop();
    }
  }

  void _initializeSelectedWords() {
    if (_selectedCategoryId == null || !_prompts.containsKey(_selectedCategoryId)) return;

    final promptData = _prompts[_selectedCategoryId!];
    final words = promptData['words'] as Map<String, dynamic>;
    
    final newSelectedWords = <String, String>{};
    words.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        newSelectedWords[key] = value.first as String;
      }
    });

    setState(() {
      _selectedWords = newSelectedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_currentStep != 2)
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _previousStep,
                    ),
                    const Text('Create New Story', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            if (_currentStep != 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalSteps, (index) {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentStep > index ? Theme.of(context).primaryColor : Colors.grey[300],
                    ),
                  );
                }),
              ),
            if (_currentStep != 2) const SizedBox(height: 24),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildCurrentStep(),
              ),
            ),
            if (_currentStep != 2)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: _currentStep == 1 && _selectedCategoryId == null ? null : _nextStep,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                  ),
                  label: Text(_currentStep == _totalSteps ? 'Generate Story' : 'Continue'),
                  icon: Icon(_currentStep == _totalSteps ? Icons.auto_awesome : Icons.arrow_forward),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      case 4:
        return _buildStep4();
      default:
        return _buildStep1();
    }
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Text('Choose a Story Category', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('What kind of adventure should we create?', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: storyCategories.length,
            itemBuilder: (context, index) {
              final category = storyCategories[index];
              final isSelected = _selectedCategoryId == category.id;
              return GestureDetector(
                onTap: () => _onCategorySelected(category.id),
                child: Card(
                  elevation: isSelected ? 4 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.05) : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: category.gradient,
                        ),
                        child: Center(
                          child: Text(category.icon, style: const TextStyle(fontSize: 30)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(category.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    final selectedCategory = _selectedCategoryId != null
        ? storyCategories.firstWhere((c) => c.id == _selectedCategoryId)
        : null;

    if (selectedCategory == null || !_prompts.containsKey(selectedCategory.id)) {
      return const Center(child: Text('Please select a category first.'));
    }

    final promptData = _prompts[selectedCategory.id];
    final String template = promptData['template'];
    final Map<String, dynamic> wordsOptions = promptData['words'];

    return Stack(
      key: const ValueKey('step2'),
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: selectedCategory.gradient,
          ),
        ),
        Positioned(
          top: 16,
          left: 4,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _previousStep,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 28, color: Colors.white, height: 1.5, shadows: [
                  Shadow(blurRadius: 8.0, color: Colors.black45, offset: Offset(0, 2))
                ]),
                children: _buildTappableText(template, wordsOptions),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton.icon(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            label: const Text('Continue'),
            icon: const Icon(Icons.arrow_forward),
          ),
        )
      ],
    );
  }

  List<TextSpan> _buildTappableText(String template, Map<String, dynamic> wordsOptions) {
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(r'\{(\w+)\}');

    template.splitMapJoin(
      exp,
      onMatch: (Match m) {
        final key = m.group(1);
        if (key != null && _selectedWords.containsKey(key)) {
          spans.add(
            TextSpan(
              text: _selectedWords[key],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
                decorationColor: Colors.white70,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showWordPicker(key, wordsOptions[key] as List);
                },
            ),
          );
        }
        return '';
      },
      onNonMatch: (String nonMatch) {
        spans.add(TextSpan(text: nonMatch));
        return '';
      },
    );

    return spans;
  }

  void _showWordPicker(String key, List<dynamic> options) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: options.map((option) {
              final isSelected = _selectedWords[key] == option;
              return ChoiceChip(
                label: Text(option as String),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedWords[key] = option;
                    });
                    Navigator.pop(context);
                  }
                },
                backgroundColor: Colors.grey[200],
                selectedColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                pressElevation: 2,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      key: const ValueKey('step3'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Column(
              children: [
                Text('Customize Your Story', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Make it personal for your little one', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      const Text('Character Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _childNameController, label: "Child's Name", hint: "Enter your child's name"),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _ageController, label: "Age", hint: "How old are they?", keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _favoriteAnimalController, label: "Favorite Animal", hint: "What's their favorite animal?"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      const Text('Story Setting', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _settingController, label: "Where should the story take place?", hint: "e.g., magical forest, space station..."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    final selectedCategory = _selectedCategoryId != null
        ? storyCategories.firstWhere((c) => c.id == _selectedCategoryId)
        : null;

    return SingleChildScrollView(
      key: const ValueKey('step4'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Text('Review & Generate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Here's what your story will include", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Card(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      const Text('Story Preview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (selectedCategory != null)
                    _buildReviewRow(
                      'Category:',
                      selectedCategory.name,
                    ),
                  if (_childNameController.text.isNotEmpty)
                    _buildReviewRow('Main Character:', _childNameController.text),
                  if (_favoriteAnimalController.text.isNotEmpty)
                    _buildReviewRow('Companion:', _favoriteAnimalController.text),
                  if (_settingController.text.isNotEmpty)
                    _buildReviewRow('Setting:', _settingController.text),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.purple.shade50,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.purple[400]),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Magic Ready!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple[800])),
                        const SizedBox(height: 4),
                        Text("We'll create a unique story with beautiful backgrounds just for you.",
                            style: TextStyle(color: Colors.purple[600], fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Chip(
            label: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
