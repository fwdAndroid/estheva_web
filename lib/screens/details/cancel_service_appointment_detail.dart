import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';

class CancelServiceAppointmentDetail extends StatefulWidget {
  final appointmentDate;
  final appointmentEndTime;
  final appointmentId;
  final appointmentStartTime;
  final doctorName;
  final patientContact;
  final patientName;
  final patientUid;
  final price;
  final serviceCategory;
  final serviceDescription;
  final serviceName;
  final status;
  final gender;

  const CancelServiceAppointmentDetail({
    super.key,
    required this.appointmentDate,
    required this.appointmentEndTime,
    required this.appointmentId,
    required this.appointmentStartTime,
    required this.doctorName,
    required this.patientContact,
    required this.patientName,
    required this.patientUid,
    required this.price,
    required this.serviceCategory,
    required this.gender,
    required this.serviceDescription,
    required this.serviceName,
    required this.status,
  });

  @override
  State<CancelServiceAppointmentDetail> createState() =>
      _CancelServiceAppointmentDetailState();
}

class _CancelServiceAppointmentDetailState
    extends State<CancelServiceAppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
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
                            widget.patientName,
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
                      child: Row(
                        children: [
                          Text(
                            "Service Description:     ", // Display the formatted date
                            style: TextStyle(
                              fontFamily: 'Futura',
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.serviceDescription,
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
