import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/uitls/colors.dart';

class Cancelled extends StatefulWidget {
  const Cancelled({super.key});

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => AppointmentDetail()));
              },
              child: SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/doctor.png",
                            height: 90,
                            width: 90,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Doctor Farhan Ali",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: appColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: cancelColor),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: Text(
                                        "Cancelled",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: mainColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "+82312412414424",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: appColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "21/11/2023",
                                    style: GoogleFonts.poppins(
                                        color: dateColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "|",
                                    style: GoogleFonts.poppins(
                                        color: dateColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "5:pm",
                                    style: GoogleFonts.poppins(
                                        color: dateColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: dividerColor,
              ),
            )
          ],
        );
      }),
    );
  }
}
