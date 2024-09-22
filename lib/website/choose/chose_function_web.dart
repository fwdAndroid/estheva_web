import 'package:estheva_web/website/screens/main_dashboard_we.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChoseFunctionWeb extends StatefulWidget {
  const ChoseFunctionWeb({super.key});

  @override
  State<ChoseFunctionWeb> createState() => _ChoseFunctionWebState();
}

class _ChoseFunctionWebState extends State<ChoseFunctionWeb> {
  void _navigateToServices(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainDashboardWeb(type: type),
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
