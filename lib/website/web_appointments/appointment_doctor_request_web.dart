import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/services/storage_methods.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/website/screens/web_dashboard_doctors.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AppointmentDoctorRequestWeb extends StatefulWidget {
  final fullName;
  final experience;
  final about;
  final photoURL;
  final doctorId;

  final price;
  final paitientName;
  final problem;
  final dob;
  final file;
  final paitientId;
  final gender;
  AppointmentDoctorRequestWeb({
    super.key,
    required this.file,
    required this.doctorId,
    required this.about,
    required this.dob,
    required this.experience,
    required this.fullName,
    required this.gender,
    required this.paitientName,
    required this.photoURL,
    required this.paitientId,
    required this.price,
    required this.problem,
  });

  @override
  State<AppointmentDoctorRequestWeb> createState() =>
      _AppointmentDoctorRequestWebState();
}

class _AppointmentDoctorRequestWebState
    extends State<AppointmentDoctorRequestWeb> {
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
                  paitientId: widget.paitientId,
                  problem: widget.problem,
                  paitientName: widget.paitientName,
                  gender: widget.gender,
                  dob: widget.dob,
                  file: widget.file,
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

class FormSection extends StatefulWidget {
  final fullName;
  final experience;
  final about;
  final photoURL;
  final doctorId;
  final price;
  final paitientName;
  final problem;
  final paitientId;
  final dob;
  final file;
  final gender;
  FormSection({
    super.key,
    required this.file,
    required this.doctorId,
    required this.about,
    required this.dob,
    required this.experience,
    required this.paitientId,
    required this.fullName,
    required this.gender,
    required this.paitientName,
    required this.photoURL,
    required this.price,
    required this.problem,
  });

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  String currentTime = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('EEEE, d MMM, yyyy');

    setState(() {
      currentTime = timeFormat.format(now); // Format for time
      currentDate = dateFormat.format(now); // Format for date
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _dateController = TextEditingController();
    TextEditingController _timeController = TextEditingController();
    TextEditingController _endTimeController = TextEditingController();
    bool isLoading = false;
    return Container(
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.memory(
                        widget.file,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Patient Name: ",
                                  style: GoogleFonts.poppins(
                                      color: appColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.paitientName,
                                  style: GoogleFonts.poppins(
                                      color: appColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date of Birth: ",
                                  style: GoogleFonts.poppins(
                                      color: appColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.dob,
                                  style: GoogleFonts.poppins(
                                      color: appColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              widget.problem,
                              style: GoogleFonts.poppins(
                                color: dateColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Appointment Date",
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  TextFormField(
                    controller: _dateController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Appointment Time",
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  TextFormField(
                    onTap: () async {},
                    controller: _timeController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Appointment End Time",
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  TextFormField(
                    onTap: () async {},
                    controller: _endTimeController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                title: "Confirm Appointment",
                onTap: () async {
                  var uuid = Uuid().v4();
                  if (_dateController.text.isEmpty ||
                      _timeController.text.isEmpty) {
                    showMessageBar(
                        "Appointment Time and Date is Required ", context);
                  } else {
                    String photoURL =
                        await StorageMethods().uploadImageToStorage(
                      'DoctorDocument',
                      widget.file,
                    );
                    await FirebaseFirestore.instance
                        .collection("doctor_appointment")
                        .doc(uuid)
                        .set({
                      //Time
                      "appointmentDate": _dateController.text,
                      "appointmentStartTime": _timeController.text,
                      "appointmentEndTime": _endTimeController.text,
                      //Patient

                      "file": photoURL,

                      "paitientName": widget.paitientName,

                      //Doctors
                      "doctorName": widget.fullName,

                      "doctorId": widget.doctorId,

                      //Status
                      "paitientUid": FirebaseAuth.instance.currentUser!.uid,
                      "paitientProblem": widget.problem,
                      "gender": widget.gender,
                      "paitientDate": widget.dob,
                      "status": "send",
                      "price": int.parse(widget.price),

                      //UUid
                      "appointmentId": uuid
                    });

                    showMessageBar("Appointment Done", context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => WebDashboardDoctors()));
                  }
                },
              ),
            ),
          ],
        ),
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
