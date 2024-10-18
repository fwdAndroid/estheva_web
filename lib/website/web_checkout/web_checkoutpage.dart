import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/website/screens/appointment_web/service_appointment_web/upcoming_service_appointment_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckOutPageWeb extends StatefulWidget {
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
  const CheckOutPageWeb({
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
  State<CheckOutPageWeb> createState() => _CheckOutPageWebState();
}

class _CheckOutPageWebState extends State<CheckOutPageWeb> {
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

class FormSelection extends StatefulWidget {
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
  State<FormSelection> createState() => _FormSelectionState();
}

class _FormSelectionState extends State<FormSelection> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
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
                          "Check Out Page",
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
                                color: appColor,
                                fontFamily: 'Futura',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8),
                        child: Row(
                          children: [
                            Text(
                              "Total Service Time:     ", // Display the formatted date
                              style: TextStyle(
                                color: appColor,
                                fontFamily: 'Futura',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.appointmentServiceTime,
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
                                color: appColor,
                                fontSize: 14,
                                fontFamily: 'Futura',
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
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
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
                          "Service Price",
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
                              "Price:     ", // Display the formatted date
                              style: TextStyle(
                                color: appColor,
                                fontSize: 14,
                                fontFamily: 'Futura',
                              ),
                            ),
                            Text(
                              widget.price.toString(),
                              style: TextStyle(
                                fontFamily: 'Futura',
                                color: dateColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SaveButton(
                          title: "Paid",
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestore.instance
                                .collection("appointment")
                                .doc(widget.appointmentId)
                                .set({
                              "gender": widget.gender,
                              "patientName": widget.patientName,
                              "doctorName": widget.doctorName,
                              "patientContact": widget.patientContact,
                              "appointmentDate": widget.appointmentDate,
                              "appointmentStartTime":
                                  widget.appointmentStartTime,
                              "appointmentServiceTime":
                                  widget.appointmentServiceTime,
                              "serviceName": widget.serviceName,
                              "serviceCategory": widget.serviceCategory,
                              "serviceDescription": widget.serviceDescription,
                              "status": "confirm",
                              "price": int.parse(widget.price),
                              "patientUid":
                                  FirebaseAuth.instance.currentUser!.uid,
                              "appointmentId": widget.appointmentId,
                            });
                            setState(() {
                              isLoading = false;
                            });
                            showMessageBar("Booking is Confirmed", context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        UpcomingServiceAppointmentWeb()));
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
