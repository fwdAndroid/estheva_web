import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:estheva_web/screens/appointments/appoinment_request.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:intl/intl.dart';
import 'package:estheva_web/uitls/image_utils.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';

class AppointmentBegin extends StatefulWidget {
  final experience;
  final name;
  final uuid;
  final photo;
  final doctorCategory;
  final price;
  final type;
  AppointmentBegin({
    super.key,
    required this.doctorCategory,
    required this.experience,
    required this.name,
    required this.price,
    required this.photo,
    required this.uuid,
    required this.type,
  });

  @override
  State<AppointmentBegin> createState() => _AppointmentBeginState();
}

class _AppointmentBeginState extends State<AppointmentBegin> {
  @override
  void initState() {
    super.initState();
    fetchUsersDetails();
    _updateTime();
  }

  String currentTime = '';
  String currentDate = '';

  TextEditingController _paitnetNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  void fetchUsersDetails() async {
    // Fetch data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched datak
    setState(() {
      _paitnetNameController.text = data['fullName'];
      _phoneController.text = (data['contactNumber']); // Convert int to string
    });
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Make Appointment",
          style: TextStyle(
            fontSize: 17,
            color: appColor,
            fontFamily: 'Futura',
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    size: 20,
                    Icons.arrow_back_ios_new,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        widget.photo,
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
                              widget.name,
                              style: TextStyle(
                                  fontFamily: 'Futura',
                                  color: appColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              widget.experience + " Years",
                              style: TextStyle(
                                fontFamily: 'Futura',
                                color: dateColor,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  currentDate, // Display the formatted date
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  currentTime,
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < 5
                                      ? Colors.yellow[600]
                                      : Colors.grey[400], // Colored stars
                                );
                              }),
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
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
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
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Futura',
                    ),
                  ),
                  TextFormInputField(
                    controller: _phoneController,
                    hintText: "Contact Number",
                    textInputType: TextInputType.number,
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Futura',
                    ),
                  ),
                  TextFormInputField(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime(3000),
                        firstDate: DateTime(2015),
                        initialDate: DateTime.now(),
                      );
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
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
                style: TextStyle(
                  color: appColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Futura',
                ),
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
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontFamily: 'Futura',
                  ),
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
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontFamily: 'Futura',
                  ),
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
                  style: TextStyle(fontSize: 14, color: textColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Write Your Problem",
                style: TextStyle(
                  color: appColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Futura',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _aboutController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: black,
                  fontFamily: 'Futura',
                ),
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
                    hintStyle: TextStyle(
                        fontFamily: 'Futura', color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Upload Document",
                style: TextStyle(
                  color: appColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Futura',
                ),
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
                    if (_paitnetNameController.text.isEmpty) {
                      showMessageBar("Patient Name is Required", context);
                    } else if (_dateController.text.isEmpty) {
                      showMessageBar("Date of Birth is Required", context);
                    } else if (_aboutController.text.isEmpty) {
                      showMessageBar("Description is Required", context);
                    } else if (_phoneController.text.isEmpty) {
                      showMessageBar("Contact Number is Required", context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AppoinmentRequest(
                                    type: widget.type,
                                    contactNumber: _phoneController.text.trim(),
                                    paitientName:
                                        _paitnetNameController.text.trim(),
                                    dob: _dateController.text.trim(),
                                    doctorUuid: widget.uuid,
                                    doctorname: widget.name,
                                    gender: _selectedGender,
                                    paitientProblem:
                                        _aboutController.text.trim(),
                                    paitientUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    uploadedDocument: _image ?? "",
                                    price: widget.price.toString(),
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
