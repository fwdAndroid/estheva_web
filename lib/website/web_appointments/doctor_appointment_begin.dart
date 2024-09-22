import 'dart:typed_data';

import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/image_utils.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/website/web_appointments/appointment_doctor_request_web.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentBegin extends StatefulWidget {
  final fullName;
  final experience;
  final about;
  final doctorId;
  final photoURL;

  final price;
  DoctorAppointmentBegin({
    super.key,
    required this.about,
    required this.doctorId,
    required this.experience,
    required this.fullName,
    required this.photoURL,
    required this.price,
  });

  @override
  State<DoctorAppointmentBegin> createState() => _DoctorAppointmentBeginState();
}

class _DoctorAppointmentBeginState extends State<DoctorAppointmentBegin> {
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

class FormSection extends StatefulWidget {
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

  String _selectedGender = 'Male'; // Variable to track the selected gender
  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    TextEditingController _paitnetNameController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    TextEditingController _aboutController = TextEditingController();
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
                      Image.network(
                        widget.photoURL,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.fullName,
                              style: GoogleFonts.poppins(
                                  color: appColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Text(
                                  currentDate, // Display the formatted date
                                  style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  currentTime,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
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
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Patient Name",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextFormInputField(
                    controller: _paitnetNameController,
                    hintText: "Patient Name",
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date of Birth",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextFormInputField(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime(3000),
                        firstDate: DateTime(2015),
                        initialDate: DateTime.now(),
                      );
                      if (pickedDate == null) return;
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    },
                    preFixICon: Icons.date_range,
                    controller: _dateController,
                    hintText: "Date of Birth",
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            // Radio Buttons in a Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Gender",
                style: GoogleFonts.poppins(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Male',
                  style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                ),
                Radio<String>(
                  value: 'Female',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Female',
                  style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                ),
                Radio<String>(
                  value: 'Other',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Other',
                  style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Write Your Problem",
                style: GoogleFonts.poppins(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _aboutController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.plusJakartaSans(color: black),
                maxLines: 3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "About Me ",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Upload Document",
                style: GoogleFonts.poppins(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => selectImage(),
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 59, backgroundImage: MemoryImage(_image!))
                        : GestureDetector(
                            onTap: () => selectImage(),
                            child: Image.asset('assets/image.png')),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                  title: "Next",
                  onTap: () {
                    if (_paitnetNameController.text.isEmpty ||
                        _aboutController.text.isEmpty ||
                        _dateController.text.isEmpty) {
                      showMessageBar(
                          "Patient Name, Date of Birth and Patient Issue is required ",
                          context);
                    } else {
                      print(_paitnetNameController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AppointmentDoctorRequestWeb(
                                    file: _image,
                                    about: widget.about,
                                    doctorId: widget.doctorId,
                                    paitientId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    dob: _dateController.text,
                                    experience: widget.experience,
                                    fullName: widget.fullName,
                                    gender: _selectedGender,
                                    paitientName: _paitnetNameController.text,
                                    photoURL: widget.photoURL,
                                    price: int.parse(widget.price),
                                    problem: _aboutController.text,
                                  )));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
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
