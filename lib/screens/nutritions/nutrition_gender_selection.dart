import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/screens/nutritions/nutrition_date_selection.dart';
import 'package:flutter/material.dart';

import '../../uitls/colors.dart';

class NutritionGenderSelection extends StatefulWidget {
  final String selectedGoal;
  NutritionGenderSelection({super.key, required this.selectedGoal});

  @override
  State<NutritionGenderSelection> createState() =>
      _NutritionGenderSelectionState();
}

class _NutritionGenderSelectionState extends State<NutritionGenderSelection> {
  String? selectedGender; // State variable to track selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top part with back and skip buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle back button press
                    },
                    icon: Icon(Icons.arrow_back_ios, color: black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => MainDashboard(type: 'clinic'),
                        ),
                      );
                      // Handle skip button press
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              // Middle part with the title, subtitle, and selection options
              Column(
                children: [
                  Text(
                    '3 / 8',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'What is your ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'gender?',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We will use this data to give you\na better diet type for you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Selection options for gender
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGenderOption(
                        icon: Icons.male,
                        label: 'Male',
                        value: 'Male',
                      ),
                      _buildGenderOption(
                        icon: Icons.female,
                        label: 'Female',
                        value: 'Female',
                      ),
                    ],
                  ),
                ],
              ),
              // Bottom circular progress and forward button
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 0.305, // Adjust this value for progress
                        strokeWidth: 6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: black),
                      onPressed: selectedGender != null
                          ? () {
                              // Navigate to the next screen, passing the selected goal and gender
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => NutritionDateSelection(
                                    selectedGoal: widget.selectedGoal,
                                    selectedGoalGender: selectedGender!,
                                  ),
                                ),
                              );
                            }
                          : null, // Disable if no option is selected
                      iconSize: 40,
                      color: Colors.orange,
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(
                        minWidth: 60,
                        minHeight: 60,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for building gender selection options
  Widget _buildGenderOption({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = value;
        });
      },
      child: Container(
        color: selectedGender == value
            ? Colors.orange
            : Colors.grey[400], // Highlight if selected
        child: Center(
          child: Column(
            children: [
              Icon(
                icon,
                color: white,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                label,
                style: TextStyle(color: white),
              ),
            ],
          ),
        ),
        width: 100,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
