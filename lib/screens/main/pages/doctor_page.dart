import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/screens/details/doctor_detail.dart';
import 'package:estheva_web/uitls/colors.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Medical Consultation",
          style: GoogleFonts.poppins(
              fontSize: 18, color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("doctors")
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No data available'));
                    }
                    var snap = snapshot.data;
                    return GridView.builder(
                      scrollDirection:
                          Axis.vertical, // Keep the scroll direction vertical
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 10, // Spacing between rows
                        childAspectRatio:
                            0.8, // Adjust this ratio to fit the design
                      ),
                      itemCount: snap
                          .docs.length, // Replace with your dynamic list length
                      itemBuilder: (context, index) {
                        var doctorData = snap.docs[index].data();
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => DoctorDetail(
                                          doctorCategory:
                                              doctorData['doctorCategory'],
                                          price: doctorData['price'],
                                          experience: doctorData['experience'],
                                          description:
                                              doctorData['doctorDescription'],
                                          name: doctorData['doctorName'],
                                          photo: doctorData['photoURL'],
                                          uuid: doctorData['uuid'],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Center the content vertically
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Center the content horizontally
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      doctorData['photoURL'],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit
                                          .cover, // Ensures the image fits properly
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 8, right: 4),
                                  child: Text(
                                    doctorData['doctorName'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 2, right: 4),
                                  child: Text(
                                    doctorData['doctorCategory'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
