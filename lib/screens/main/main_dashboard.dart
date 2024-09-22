import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/screens/main/pages/appointment_page.dart';
import 'package:estheva_web/screens/main/pages/doctor_page.dart';
import 'package:estheva_web/screens/main/pages/history_page.dart';
import 'package:estheva_web/screens/main/pages/home_page.dart';
import 'package:estheva_web/screens/nutritions/nutritions.dart';
import 'package:estheva_web/uitls/colors.dart';

class MainDashboard extends StatefulWidget {
  String type;
  MainDashboard({super.key, required this.type});
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomePage(
        type: widget.type,
      ),
      DoctorPage(),
      AppointmentPage(),
      HistoryPage(),
      Nutritions()
    ];
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: mainColor),
            unselectedLabelStyle: TextStyle(color: textColor),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? Image.asset(
                        "assets/home_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/home_grey.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? Image.asset(
                        "assets/doctor_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/doctor_grey.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'Doctor',
                backgroundColor: white,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 2
                    ? Image.asset(
                        "assets/calender_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/calender_grey.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'Appointment',
                backgroundColor: white,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 3
                    ? Image.asset(
                        "assets/history_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/history_medic.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'History',
                backgroundColor: white,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 4
                    ? Icon(Icons.nature_outlined, color: mainColor)
                    : Icon(
                        Icons.nature_people_outlined,
                        color: Colors.grey,
                      ),
                label: 'History',
                backgroundColor: white,
              ),
            ],
          ),
        ));
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> _showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
