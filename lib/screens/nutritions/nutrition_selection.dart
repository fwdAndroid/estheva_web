import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/screens/nutritions/nutrition_gender_selection.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';

class NutritionSelection extends StatefulWidget {
  const NutritionSelection({super.key});

  @override
  State<NutritionSelection> createState() => _NutritionSelectionState();
}

class _NutritionSelectionState extends State<NutritionSelection> {
  // Variable to hold the selected goal
  String? selectedGoal;

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
                              builder: (builder) =>
                                  MainDashboard(type: 'clinic')));
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
              // Middle part with the title, subtitle, and selectable items
              Column(
                children: [
                  Text(
                    '2 / 8',
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
                          text: 'goal?',
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
                  // Selections
                  buildGoalOption('Lose Weight'),
                  buildGoalOption('Gain Weight'),
                  buildGoalOption('Stay Healthy'),
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
                        value: 0.160, // Adjust this value for progress
                        strokeWidth: 6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: black),
                      onPressed: selectedGoal != null
                          ? () {
                              // Navigate to the next screen, passing the selected goal
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          NutritionGenderSelection(
                                              selectedGoal: selectedGoal!)));
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

  // Helper method to build each goal option
  Widget buildGoalOption(String goal) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGoal = goal; // Update selected goal
          });
        },
        child: Container(
          color: selectedGoal == goal ? Colors.orange : Colors.grey[400],
          child: Center(
            child: ListTile(
              trailing: Icon(Icons.line_weight),
              title: Text(
                goal,
                style: TextStyle(color: white),
              ),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
