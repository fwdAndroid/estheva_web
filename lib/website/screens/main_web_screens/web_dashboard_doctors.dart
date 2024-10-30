import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/web_details.dart/doctor_details.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class WebDashboardDoctors extends StatefulWidget {
  const WebDashboardDoctors({super.key});

  @override
  State<WebDashboardDoctors> createState() => _WebDashboardDoctorsState();
}

class _WebDashboardDoctorsState extends State<WebDashboardDoctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("doctors")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No Doctor Available",
                          style: TextStyle(color: black),
                        ),
                      );
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(
                              context), // Adjust the number of columns based on screen size
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio:
                              1.0, // Adjust child aspect ratio as needed
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          final Map<String, dynamic> data =
                              documents[index].data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => WebDoctorDetail(
                                            photoURL: data['photoURL'],
                                            fullName: data['doctorName'],
                                            experience: data['experience'],
                                            about: data['doctorDescription'],
                                            price: data['price'].toString(),
                                            doctorId: data['uuid'],
                                          )));
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 200,
                                        data['photoURL'],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, top: 8, right: 4),
                                    child: Text(
                                      data['doctorName'],
                                      style: TextStyle(
                                          fontFamily: 'Futura',
                                          fontSize: 12,
                                          color: appColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  // Adjust the crossAxisCount based on the screen width
  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 6; // 6 columns for large screens
    } else if (screenWidth > 800) {
      return 4; // 4 columns for medium screens
    } else {
      return 2; // 2 columns for small screens
    }
  }
}
