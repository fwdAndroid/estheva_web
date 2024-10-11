import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentCompletedDetail extends StatefulWidget {
  final appointmentDate;
  final appointmentEndTime;
  final appointmentId;
  final appointmentStartTime;
  final doctorId;
  final doctorName;
  final file;
  final gender;
  final paitientName;
  final paitientDate;
  final paitientProblem;
  final paitientUid;
  final price;
  final status;
  const DoctorAppointmentCompletedDetail(
      {super.key,
      required this.appointmentDate,
      required this.appointmentEndTime,
      required this.appointmentId,
      required this.appointmentStartTime,
      required this.doctorId,
      required this.doctorName,
      required this.file,
      required this.gender,
      required this.paitientDate,
      required this.paitientName,
      required this.paitientProblem,
      required this.paitientUid,
      required this.price,
      required this.status});

  @override
  State<DoctorAppointmentCompletedDetail> createState() =>
      _DoctorAppointmentCompletedDetailState();
}

class _DoctorAppointmentCompletedDetailState
    extends State<DoctorAppointmentCompletedDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //Doctor Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 360,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Doctor Detail",
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Doctor Name: ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.doctorName, // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Price:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.price.toString(),
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Appointment Schedule
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 360,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Appointment Schedule",
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Date:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget
                                .appointmentDate, // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Time:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.appointmentStartTime,
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 360,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Patient Details",
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Name:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.paitientName,
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: dateColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Gender:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.gender,
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: dateColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.paitientProblem,
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: dateColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/gen.png"),
          )
        ],
      ),
    );
  }
}
