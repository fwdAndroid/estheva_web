import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/web_details.dart/product_booking_web.dart';
import 'package:estheva_web/website/web_appointments/doctor_appointment_begin.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebDoctorDetail extends StatefulWidget {
  final fullName;
  final experience;
  final about;
  final photoURL;
  final doctorId;
  final price;
  WebDoctorDetail({
    super.key,
    required this.fullName,
    required this.experience,
    required this.about,
    required this.doctorId,
    required this.price,
    required this.photoURL,
  });

  @override
  State<WebDoctorDetail> createState() => _WebDoctorDetailState();
}

class _WebDoctorDetailState extends State<WebDoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.photoURL,
                height: 170,
                width: 500,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.fullName,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
                height: 300,
                width: 1200,
                child: Scrollbar(
                    // Add a scrollbar for the description
                    thumbVisibility: true, // Keep the scrollbar visible
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.about,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ))),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Container(
            //     color: Colors.yellow.shade100,
            //     padding: EdgeInsets.all(16),
            //     child: Row(
            //       children: [
            //         Icon(Icons.discount, color: Colors.orange),
            //         SizedBox(width: 8),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               widget.discount.toString(),
            //               style: GoogleFonts.poppins(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //               ),
            //             ),
            //             Text(
            //               "Use code SUMMER20 | above AED 10",
            //               style: GoogleFonts.poppins(
            //                 fontSize: 12,
            //                 color: Colors.black54,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.price.toString() + "AED",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Book now action
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => DoctorAppointmentBegin(
                                    photoURL: widget.photoURL,
                                    fullName: widget.fullName,
                                    experience: widget.experience,
                                    about: widget.about,
                                    doctorId: widget.doctorId,
                                    price: widget.price.toString(),
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      "Book Now",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
