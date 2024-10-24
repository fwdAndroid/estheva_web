import 'dart:math'; // For generating random values
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalResult extends StatefulWidget {
  const FinalResult({Key? key}) : super(key: key);

  @override
  State<FinalResult> createState() => _FinalResultState();
}

class _FinalResultState extends State<FinalResult> {
  late double height;
  late double weight;
  late int age;
  late double bmr;
  late double totalCalories;
  late double caloriesBurned;

  @override
  void initState() {
    super.initState();

    // Generate random values
    Random random = Random();
    height = random.nextInt(50) + 150; // Height between 150cm and 200cm
    weight = random.nextInt(50) + 50; // Weight between 50kg and 100kg
    age = random.nextInt(40) + 20; // Age between 20 and 60 years

    // Assuming male for BMR calculation
    bmr = calculateBMR("male", height, weight, age);
    totalCalories = calculateTotalCalories(bmr);
    caloriesBurned = calculateCaloriesBurned(bmr); // Simulated burned calories
  }

  // Calculate BMR using the gender, height, weight, and age
  double calculateBMR(String gender, double height, double weight, int age) {
    if (gender.toLowerCase() == 'male') {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
  }

  // Calculate total daily calories (TDEE) based on a fixed activity factor
  double calculateTotalCalories(double bmr) {
    const double activityFactor = 1.55; // Assuming moderately active
    return bmr * activityFactor;
  }

  // Simulate calories burned during the day (you can replace with real calculations)
  double calculateCaloriesBurned(double bmr) {
    return bmr * 0.8; // Example: burn 80% of BMR value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Good Morning 🌟',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              // Circular progress with calories burned and target
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            strokeWidth: 12,
                            value: caloriesBurned / totalCalories,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange),
                          ),
                        ),
                        Column(
                          children: [
                            Icon(Icons.fitness_center,
                                size: 40, color: Colors.orange),
                            SizedBox(height: 10),
                            Text(
                              'Calories Burned',
                              style: TextStyle(
                                  fontSize: 18, color: CupertinoColors.white),
                            ),
                            Text(
                              '${caloriesBurned.toStringAsFixed(0)} kcal',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                            Text(
                              'of ${totalCalories.toStringAsFixed(0)} kcal',
                              style: TextStyle(fontSize: 16, color: white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Display the randomly generated height, weight, and age

              SizedBox(height: 10),
              Text('Height: ${height.toStringAsFixed(0)} cm'),
              Text('Weight: ${weight.toStringAsFixed(0)} kg'),
              Text('Age: $age years'),
              Spacer(),
              SaveButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MainDashboard(type: "clinic")));
                },
                title: "Exit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
