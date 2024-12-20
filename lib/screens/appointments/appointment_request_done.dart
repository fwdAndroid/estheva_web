import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/uitls/colors.dart';

class AppointmentRequestDone extends StatefulWidget {
  final type;
  const AppointmentRequestDone({
    required this.type,
    super.key,
  });

  @override
  State<AppointmentRequestDone> createState() => _AppointmentRequestDoneState();
}

class _AppointmentRequestDoneState extends State<AppointmentRequestDone> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  "assets/success icon.png",
                  width: 150,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Appointment Success!",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 20,
                        color: appColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    height: 60,
                    child: Text(
                      "Your appointment has been successfully scheduled. You can see details from your  Appointments Tab.",
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 14,
                          color: textColor,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MainDashboard(
                                    type: widget.type,
                                  )));
                    },
                    child: Image.asset(
                      "assets/home.png",
                      height: 48,
                      width: 160,
                    ),
                  ),
                ),
              )
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
