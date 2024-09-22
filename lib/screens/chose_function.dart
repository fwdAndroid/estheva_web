import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:flutter/material.dart';

class ChoseFunction extends StatefulWidget {
  const ChoseFunction({super.key});

  @override
  State<ChoseFunction> createState() => _ChoseFunctionState();
}

class _ChoseFunctionState extends State<ChoseFunction> {
  void _navigateToServices(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainDashboard(type: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/newlogo.png",
              height: 170,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _navigateToServices('home'),
                child: SizedBox(
                    height: 170,
                    width: 170,
                    child: Image.asset(
                      "assets/blue.png",
                      fit: BoxFit.cover,
                    )),
              ),
              GestureDetector(
                onTap: () => _navigateToServices('clinic'),
                child: SizedBox(
                    height: 170,
                    width: 170,
                    child: Image.asset(
                      "assets/pink.png",
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
