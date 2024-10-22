import 'package:flutter/material.dart';

class FinalGoal extends StatefulWidget {
  final dob, gender, goal, height, target_weight, finalgoal;
  const FinalGoal(
      {super.key,
      required this.dob,
      required this.gender,
      required this.goal,
      required this.height,
      required this.target_weight,
      required this.finalgoal});

  @override
  State<FinalGoal> createState() => _FinalGoalState();
}

class _FinalGoalState extends State<FinalGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Circular Progress and Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100), // Add space above the progress section
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent[100]!),
                    ),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons
                          .bar_chart, // Icon similar to the one in the screenshot
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Preparing your plan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Setting up your nutrition plan and\nanalyzing your goals...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          // Bottom "Next" Button
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle "Next" button action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Background color
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
