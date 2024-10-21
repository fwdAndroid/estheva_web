import 'package:estheva_web/screens/nutritions/work_out.dart';
import 'package:flutter/material.dart';

class Nutritions extends StatefulWidget {
  const Nutritions({super.key});

  @override
  State<Nutritions> createState() => _NutritionsState();
}

class _NutritionsState extends State<Nutritions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nutritions'),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset("assets/diet.png"),
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
                  'Know What You Eat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10),

                // Subtitle Text
                Text(
                  'Gain insights in your nutritional habits with detailed statistics',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => WorkOut()));
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
