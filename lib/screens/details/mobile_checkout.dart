import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/email/email.dart';
import 'package:estheva_web/email/send_email.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/screens/tabs/service_appointment_details.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MobileCheckout extends StatefulWidget {
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
  MobileCheckout({
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
  State<MobileCheckout> createState() => _MobileCheckoutState();
}

class _MobileCheckoutState extends State<MobileCheckout> {
  bool isLoading = false;

  String formatAppointmentDate(String dateStr) {
    try {
      // Parse the date string
      DateTime parsedDate = DateTime.parse(dateStr);
      // Format the date to the desired format: "23 October 2023"
      String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      // In case of an error, return the original string
      return dateStr;
    }
  }
  // Future<void> sendEmail(String email, String appointmentDetails) async {
  //   final smtpServer = gmail(
  //       'fwdkaleem@gmail.com', '21121993Fawad'); // Use your email credentials
  //   final message = Message()
  //     ..from = Address('your_email@gmail.com', 'Your App Name')
  //     ..recipients.add(email) // Email of the user
  //     ..subject = 'Appointment Confirmation'
  //     ..text = appointmentDetails; // Email content with appointment details

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent. ${e.toString()}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => MainDashboard(type: "clinic")));
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: white),
              ))
        ],
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Appointment Schedule
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
                              formatAppointmentDate(widget.appointmentDate),
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
                              widget.appointmentStartTime.toString(),
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
                              "Total Service Time: ", // Display the formatted date
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
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SaveButton(
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
                                      "appointmentDate":
                                          widget.appointmentDate.toString(),
                                      "appointmentStartTime": widget
                                          .appointmentStartTime
                                          .toString(),
                                      "appointmentServiceTime":
                                          widget.appointmentServiceTime,
                                      "serviceName": widget.serviceName,
                                      "serviceCategory": widget.serviceCategory,
                                      "serviceDescription":
                                          widget.serviceDescription,
                                      "status": "confirm",
                                      "price": int.parse(widget.price),
                                      "patientUid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "appointmentId": widget.appointmentId,
                                    });

                                    setState(() {
                                      isLoading = false;
                                    });
                                    showMessageBar(
                                        "Booking is Confirmed", context);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ServiceAppointmentDetails()));
                                    try {
                                      await EmailSendClass.sendEmail(
                                        body:
                                            'Dear Estheva Polyclinic,\n There is a new appointment available on your dashboard, Hurry up and check it!\n\n  Job ID: $widget,appointmentId\n\nCustomer Full Name: ${widget.patientName}\n\nCustomer number: ${widget.patientContact}\n\nService Description:\n$widget.serviceDescription\nAppointment Date: $widget.appointmentDate.toString(),\n\nExpected Time: $widget.appointmentServiceTime',
                                        email: "fwdkaleem@gmail.com",
                                        subject: "New Order!",
                                      );
                                    } catch (e) {
                                      debugPrint("sendEmail failed ${e}");
                                    }
                                  }),
                            )
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
