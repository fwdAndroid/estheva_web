import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/uitls/colors.dart';

class DoctorAppointmentDetails extends StatefulWidget {
  const DoctorAppointmentDetails({super.key});

  @override
  State<DoctorAppointmentDetails> createState() =>
      _DoctorAppointmentDetailsState();
}

class _DoctorAppointmentDetailsState extends State<DoctorAppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        centerTitle: true,
        title: Text(
          'Doctor Appointment ',
          style: TextStyle(color: white),
        ),
        backgroundColor: mainColor,
      ),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("doctor_appointment")
              .where("paitientUid",
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
                      trailing:
                          TextButton(onPressed: () {}, child: Text("View")),
                      title: Row(
                        children: [
                          Text(
                            "Doctor Name:",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: appColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            serviceData['doctorName'],
                            style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: appColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentDate'],
                                style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: appColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentStartTime'],
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: appColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                      // Column(children: [
                      //   Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Text(
                      //                 serviceData['doctorName'],

                      //               const SizedBox(
                      //                 width: 3,
                      //               ),
                      //               Container(
                      //                 width: 80,
                      //                 height: 24,
                      //                 decoration: BoxDecoration(
                      //                     border:
                      //                         Border.all(color: contColor),
                      //                     borderRadius:
                      //                         BorderRadius.circular(4)),
                      //                 child: Center(
                      //                   child: Text(
                      //                     "Upcoming",
                      //                     style: GoogleFonts.poppins(
                      //                         fontSize: 12, color: mainColor),
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: [
                      //               Text(
                      //                 serviceData['appointmentDate'],
                      //                 style: GoogleFonts.poppins(
                      //                     color: dateColor,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w300),
                      //               ),
                      //               const SizedBox(
                      //                 width: 6,
                      //               ),
                      //               Text(
                      //                 "|",
                      //                 style: GoogleFonts.poppins(
                      //                     color: dateColor,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w300),
                      //               ),
                      //               const SizedBox(
                      //                 width: 6,
                      //               ),
                      //               Text(
                      //                 serviceData['appointmentStartTime'],
                      //                 style: GoogleFonts.poppins(
                      //                     color: dateColor,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w300),
                      //               )
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   )
                      // ]),

                      );
                });
          }),
    );
  }
}
