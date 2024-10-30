import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/web_appointments/appointment_web/doctor_appointment_web/doctor_appointment_detail/complete_doctor_web_appointment_detail.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompleteDoctorAppointmentWeb extends StatefulWidget {
  const CompleteDoctorAppointmentWeb({super.key});

  @override
  State<CompleteDoctorAppointmentWeb> createState() =>
      _CompleteDoctorAppointmentWebState();
}

class _CompleteDoctorAppointmentWebState
    extends State<CompleteDoctorAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("doctor_appointment")
              .where("paitientUid",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where("status", isEqualTo: "complete")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No Doctor Appointment Available Yet'));
            }
            var snap = snapshot.data;
            return ListView.builder(
                itemCount: snap.docs.length,
                itemBuilder: (context, index) {
                  var serviceData = snap.docs[index].data();
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        CompleteDoctorWebAppointmentDetail(
                                          status: serviceData['status'],
                                          appointmentDate:
                                              serviceData['appointmentDate'],
                                          paitientDate:
                                              serviceData['paitientDate'],
                                          appointmentEndTime:
                                              serviceData['appointmentEndTime'],
                                          appointmentId:
                                              serviceData['appointmentId'],
                                          appointmentStartTime: serviceData[
                                              'appointmentStartTime'],
                                          doctorId: serviceData['doctorId'],
                                          doctorName: serviceData['doctorName'],
                                          file: serviceData['file'],
                                          gender: serviceData['gender'],
                                          paitientName:
                                              serviceData['paitientName'],
                                          paitientProblem:
                                              serviceData['paitientProblem'],
                                          paitientUid:
                                              serviceData['paitientUid'],
                                          price:
                                              serviceData['price'].toString(),
                                        )));
                          },
                          child: Text(
                            "View",
                            style: TextStyle(
                              fontFamily: 'Futura',
                            ),
                          )),
                      title: Row(
                        children: [
                          Text(
                            "Doctor Name:",
                            style: TextStyle(
                                fontFamily: 'Futura',
                                fontSize: 13,
                                color: appColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            serviceData['doctorName'],
                            style: TextStyle(
                                fontFamily: 'Futura',
                                fontSize: 12,
                                color: appColor,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Date:",
                                style: TextStyle(
                                    fontFamily: 'Futura',
                                    fontSize: 13,
                                    color: appColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentDate'],
                                style: TextStyle(
                                    fontFamily: 'Futura',
                                    fontSize: 12,
                                    color: appColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Time:",
                                style: TextStyle(
                                    fontFamily: 'Futura',
                                    fontSize: 13,
                                    color: appColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentStartTime'],
                                style: TextStyle(
                                    fontFamily: 'Futura',
                                    fontSize: 12,
                                    color: appColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
                });
          }),
    );
  }
}