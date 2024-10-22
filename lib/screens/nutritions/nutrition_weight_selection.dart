import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/screens/nutritions/chose_the_process.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class NutritionWeightSelection extends StatefulWidget {
  final dob, gender, goal, height;

  NutritionWeightSelection(
      {super.key,
      required this.dob,
      required this.gender,
      required this.goal,
      required this.height});

  @override
  State<NutritionWeightSelection> createState() =>
      _NutritionWeightSelectionState();
}

class _NutritionWeightSelectionState extends State<NutritionWeightSelection> {
  TextEditingController _nameController = TextEditingController();
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
              // Middle part with the title, subtitle, and text field
              Column(
                children: [
                  Text(
                    '7 / 8',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Your ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'target weight',
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
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: TextFormInputField(
                        onTap: () async {},
                        textInputType: TextInputType.number,
                        hintText:
                            'Current Weight', // Pre-filled name or user input field can be added
                        controller: _nameController,
                      )),
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
                        value: 0.805, // Adjust this value for progress
                        strokeWidth: 6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: black),
                      onPressed: () {
                        if (_nameController.text.isEmpty) {
                          showMessageBar("Weight is Required", context);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ChoseTheProcess(
                                      target_weight: _nameController.text,
                                      height: widget.height,
                                      dob: widget.dob,
                                      gender: widget.gender,
                                      goal: widget.goal)));
                        }
                        // Handle next button press
                      },
                      iconSize: 40,
                      color: Colors.orange,
                      padding: EdgeInsets.all(0),
                      // Outer circle style
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
}
