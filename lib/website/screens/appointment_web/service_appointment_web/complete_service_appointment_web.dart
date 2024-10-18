import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/appointment_web/service_appointment_web/service_web_detail_web/service_upcomming_appointment_detail_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompleteServiceAppointmentWeb extends StatefulWidget {
  const CompleteServiceAppointmentWeb({super.key});

  @override
  State<CompleteServiceAppointmentWeb> createState() =>
      _CompleteServiceAppointmentWebState();
}

class _CompleteServiceAppointmentWebState
    extends State<CompleteServiceAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("appointment")
              .where("patientUid",
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
                                        ServiceAppointUpcommingCompletedDetailWeb(
                                          gender: serviceData['gender'],
                                          serviceCategory:
                                              serviceData['serviceCategory'],
                                          appointmentDate:
                                              serviceData['appointmentDate'],
                                          serviceDescription:
                                              serviceData['serviceDescription'],
                                          appointmentServiceTime: serviceData[
                                              'appointmentServiceTime'],
                                          serviceName:
                                              serviceData['serviceName'],
                                          appointmentId:
                                              serviceData['appointmentId'],
                                          appointmentStartTime: serviceData[
                                              'appointmentStartTime'],
                                          doctorName: serviceData['doctorName'],
                                          patientContact:
                                              serviceData['patientContact'],
                                          patientName:
                                              serviceData['patientName'],
                                          status: serviceData['status'],
                                          patientUid: serviceData['patientUid'],
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
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Service Name:",
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
                            serviceData['serviceName'],
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
                                    fontSize: 13,
                                    color: appColor,
                                    fontFamily: 'Futura',
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentDate'],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Futura',
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
                                    fontSize: 13,
                                    color: appColor,
                                    fontFamily: 'Futura',
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentStartTime'],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Futura',
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
