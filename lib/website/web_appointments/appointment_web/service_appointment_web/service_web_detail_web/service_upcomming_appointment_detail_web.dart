import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceAppointUpcommingCompletedDetailWeb extends StatefulWidget {
  final appointmentDate;
  final appointmentServiceTime;
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
  const ServiceAppointUpcommingCompletedDetailWeb({
    super.key,
    required this.appointmentDate,
    required this.appointmentServiceTime,
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
  State<ServiceAppointUpcommingCompletedDetailWeb> createState() =>
      _ServiceAppointUpcommingCompletedDetailWebState();
}

class _ServiceAppointUpcommingCompletedDetailWebState
    extends State<ServiceAppointUpcommingCompletedDetailWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                FormSelection(
                  appointmentDate: widget.appointmentDate,
                  appointmentServiceTime: widget.appointmentServiceTime,
                  appointmentId: widget.appointmentId,
                  appointmentStartTime: widget.appointmentStartTime,
                  patientContact: widget.patientContact,
                  doctorName: widget.doctorName,
                  patientName: widget.patientName,
                  serviceName: widget.serviceName,
                  serviceDescription: widget.serviceDescription,
                  patientUid: widget.patientUid,
                  price: widget.price.toString(),
                  serviceCategory: widget.serviceCategory,
                  gender: widget.gender,
                  status: widget.status,
                ),
                ImageSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSelection extends StatelessWidget {
  const ImageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logos.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}

class FormSelection extends StatelessWidget {
  final appointmentDate;
  final appointmentServiceTime;
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
  const FormSelection({
    super.key,
    required this.appointmentDate,
    required this.appointmentServiceTime,
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
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Appointment Schedule
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 500,
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
                              appointmentDate, // Display the formatted date
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
                                color: appColor,
                                fontFamily: 'Futura',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              appointmentStartTime,
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
                height: 480,
                width: 500,
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
                              patientName,
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
                                color: appColor,
                                fontSize: 14,
                                fontFamily: 'Futura',
                              ),
                            ),
                            Text(
                              gender,
                              style: TextStyle(
                                fontFamily: 'Futura',
                                color: dateColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service Description: ", // Display the formatted date
                                style: TextStyle(
                                  color: appColor,
                                  fontFamily: 'Futura',
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 500,
                                height: 360,
                                child: Text(
                                  serviceDescription,
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                    color: dateColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
