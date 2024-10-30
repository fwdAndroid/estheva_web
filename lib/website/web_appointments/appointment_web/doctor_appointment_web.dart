import 'package:estheva_web/website/web_appointments/appointment_web/doctor_appointment_web/cancel_doctor_appointment_web.dart';
import 'package:estheva_web/website/web_appointments/appointment_web/doctor_appointment_web/complete_doctor_appointment_web.dart';
import 'package:estheva_web/website/web_appointments/appointment_web/doctor_appointment_web/upcomming_doctor_appointment_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoctorAppointmentWeb extends StatefulWidget {
  const DoctorAppointmentWeb({super.key});

  @override
  State<DoctorAppointmentWeb> createState() => _DoctorAppointmentWebState();
}

class _DoctorAppointmentWebState extends State<DoctorAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/newlogo.png",
            height: 200,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  UpcommingDoctorAppointmentWeb()));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/doctor.png",
                            height: 170,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Upcoming Appointment"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  CompleteDoctorAppointmentWeb()));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/doctor.png",
                            height: 170,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Complete Appointment",
                              style: TextStyle(
                                fontFamily: 'Futura',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  CancelDoctorAppointmentWeb()));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/doctor.png",
                            height: 170,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Cancel Appointment",
                              style: TextStyle(
                                fontFamily: 'Futura',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
