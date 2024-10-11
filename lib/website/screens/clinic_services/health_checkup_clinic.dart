import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/web_details.dart/product_detail_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class HealthChecupAtClinic extends StatefulWidget {
  HealthChecupAtClinic({
    super.key,
  });

  @override
  State<HealthChecupAtClinic> createState() => _HealthChecupAtClinicState();
}

class _HealthChecupAtClinicState extends State<HealthChecupAtClinic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("services")
              .where("serviceCategory", isEqualTo: "Health Checkup")
              .where("type", isEqualTo: "clinic")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No Service available'));
            }
            var snap = snapshot.data;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(
                      context), // Adjust the number of columns based on screen size
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0, // Adjust child aspect ratio as needed
                ),
                itemCount: snap.docs.length,
                itemBuilder: (context, index) {
                  var serviceData = snap.docs[index].data();
                  return SizedBox(
                    width: 200,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ProductDetailWeb(
                                      description:
                                          serviceData['serviceDescription'],
                                      discount:
                                          serviceData['discount'].toString(),
                                      photoURL: serviceData['photoURL'],
                                      uuid: serviceData['uuid'],
                                      price: serviceData['price'].toString(),
                                      serviceCategory:
                                          serviceData['serviceCategory'],
                                      serviceName: serviceData['serviceName'],
                                      serviceSubCategory:
                                          serviceData['serviceSubCategory'],
                                    )));
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(serviceData['photoURL']),
                                radius: 60,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, right: 8),
                                child: Text(
                                  serviceData['serviceSubcategory'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: appColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffD3D3D3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      serviceData['price'].toString() + " AED",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainColor,
                                          fontFamily: 'Futura',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
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
