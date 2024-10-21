import 'package:estheva_web/screens/nutritions/height_out.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';

class WorkOut extends StatefulWidget {
  const WorkOut({super.key});

  @override
  State<WorkOut> createState() => _WorkOutState();
}

class _WorkOutState extends State<WorkOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset("assets/workout.png"),
        Spacer(),
        Center(
          child: Container(
            width: 500,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100], // Light background color
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Text
                Text(
                  'Track Your Diet',
                  style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10),

                // Subtitle Text
                Text(
                  'We will help you lose weight, stay fit, or build mode',
                  style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30),

                // Circular Progress with Button
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Arc
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 0.75, // 75% progress
                        strokeWidth: 6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),

                    // Button in the center
                    IconButton(
                      onPressed: () {
                        // Define your action here
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => HeightOut()));
                      },
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      iconSize: 30,
                      color: Colors.orange,
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                      splashRadius: 30,
                      // Circular button style
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
