import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/services/storage_methods.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/website/screens/appointment_web/doctor_appointment_web/upcomming_doctor_appointment_web.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AppointmentDoctorRequestWeb extends StatefulWidget {
  final fullName;
  final experience;
  final about;
  final photoURL;
  final doctorId;
  final paitientContact;
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
    required this.paitientContact,
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
                  paitientContact: widget.paitientContact,
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
  final paitientContact;
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
    required this.paitientContact,
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
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  var uuid = Uuid().v4();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: appColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.paitientName,
                                  style: TextStyle(
                                      fontFamily: 'Futura',
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
                                  style: TextStyle(
                                      color: appColor,
                                      fontSize: 14,
                                      fontFamily: 'Futura',
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.dob,
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: appColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              widget.problem,
                              style: TextStyle(
                                fontFamily: 'Futura',
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
            // Date Picker
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Appointment Date",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
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
                    hintText: "Appointment Date",
                    textInputType: TextInputType.name,
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
                    "Start Appointment Time",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  TextFormInputField(
                    onTap: () => _selectTime(context), // Opens the time picker
                    preFixICon: Icons.time_to_leave,
                    controller: _timeController,
                    hintText: "Appointment Time",
                    textInputType: TextInputType.name,
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
                    "End Appointment Time",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  TextFormInputField(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!,
                          );
                        },
                      );

                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final selectedTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        setState(() {
                          _endTimeController.text =
                              DateFormat('hh:mm a').format(selectedTime);
                        });
                      }
                    },
                    preFixICon: Icons.time_to_leave,
                    controller: _endTimeController,
                    hintText: "Appointment Time",
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                title: "Confirm Appointment",
                onTap: () async {
                  if (_dateController.text.isEmpty) {
                    showMessageBar("Appointment Date is Required", context);
                  } else if (_timeController.text.isEmpty) {
                    showMessageBar("Appointment Time is Required", context);
                  } else if (_endTimeController.text.isEmpty) {
                    showMessageBar("Appointment End Time is Required", context);
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
                      "status": "confirm",
                      "price": int.parse(widget.price),
                      "paitientContact": widget.paitientContact,
                      //UUid
                      "appointmentId": uuid
                    });

                    showMessageBar("Appointment Done", context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                                UpcommingDoctorAppointmentWeb()));
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
