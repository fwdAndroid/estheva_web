import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/web_appointments/doctor_appointment_begin.dart';
import 'package:estheva_web/widgets/save_button.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                FormSection(
                  fullName: widget.fullName,
                  experience: widget.experience,
                  about: widget.about,
                  doctorId: widget.doctorId,
                  photoURL: widget.photoURL,
                  price: widget.price.toString(),
                ),
                ImageSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSelection extends StatelessWidget {
  const ImageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logos.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}

class FormSection extends StatelessWidget {
  final fullName;
  final experience;
  final about;
  final photoURL;
  final doctorId;
  final price;
  const FormSection({
    super.key,
    required this.fullName,
    required this.experience,
    required this.about,
    required this.doctorId,
    required this.price,
    required this.photoURL,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(photoURL),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 17),
                    child: Text(
                      fullName,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: appColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  size: 20,
                                  Icons.badge,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            experience.toString() + " " + "Years",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: appColor),
                          ),
                          Text(
                            "Experience",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "About Doctor",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: appColor),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: Text(
                      about,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: dateColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: 360,
                    decoration: BoxDecoration(
                      color: circle,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: dividerColor,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Consultation fee",
                                style: GoogleFonts.poppins(
                                  color: dateColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$",
                                    style: GoogleFonts.poppins(
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    price.toString(),
                                    style: GoogleFonts.poppins(
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "/Consultation fee",
                                    style: GoogleFonts.poppins(
                                      color: dateColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SaveButton(
                      title: "Make Appointment",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => DoctorAppointmentBegin(
                                      photoURL: photoURL,
                                      fullName: fullName,
                                      experience: experience,
                                      about: about,
                                      doctorId: doctorId,
                                      price: price.toString(),
                                    )));
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
