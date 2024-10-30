import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/screens/details/service_appointment_complete_detail.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceAppointmentDetails extends StatefulWidget {
  const ServiceAppointmentDetails({super.key});

  @override
  State<ServiceAppointmentDetails> createState() =>
      _ServiceAppointmentDetailsState();
}

class _ServiceAppointmentDetailsState extends State<ServiceAppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        centerTitle: true,
        title: Text(
          'Service Appointment ',
          style: TextStyle(
            color: white,
            fontFamily: 'Futura',
          ),
        ),
        backgroundColor: mainColor,
      ),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("appointment")
              .where("patientUid",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where("status", isEqualTo: "confirm")
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
                                        ServiceAppointCompleteDetail(
                                          gender: serviceData['gender'],
                                          serviceCategory:
                                              serviceData['serviceCategory'],
                                          appointmentDate:
                                              serviceData['appointmentDate'],
                                          serviceDescription:
                                              serviceData['serviceDescription'],
                                          appointmentEndTime:
                                              serviceData['appointmentEndTime'],
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
