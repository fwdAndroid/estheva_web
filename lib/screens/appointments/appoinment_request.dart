import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:estheva_web/screens/appointments/appointment_request_done.dart';
import 'package:estheva_web/services/storage_methods.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:uuid/uuid.dart';

class AppoinmentRequest extends StatefulWidget {
  final gender;
  final dob;
  final paitientName;
  final doctorname;
  final doctorUuid;
  final type;
  final paitientUid;
  final paitientProblem;
  final uploadedDocument;
  final contactNumber;
  final price;
  AppoinmentRequest({
    super.key,
    required this.dob,
    required this.doctorUuid,
    required this.doctorname,
    required this.gender,
    required this.contactNumber,
    required this.type,
    required this.paitientName,
    required this.price,
    required this.paitientProblem,
    required this.paitientUid,
    required this.uploadedDocument,
  });

  @override
  State<AppoinmentRequest> createState() => _AppoinmentRequestState();
}

class _AppoinmentRequestState extends State<AppoinmentRequest> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  bool isLoading = false;
  var uuid = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Confirm Appointment",
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
      body: Column(
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
                    Image.asset(
                      "assets/logos.png",
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
                                    color: appColor,
                                    fontFamily: 'Futura',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.paitientName,
                                style: TextStyle(
                                    color: appColor,
                                    fontFamily: 'Futura',
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
                                    fontFamily: 'Futura',
                                    color: appColor,
                                    fontSize: 14,
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
                            widget.paitientProblem,
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
                        _timeController.text =
                            DateFormat('hh:mm a').format(selectedTime);
                      });
                    }
                  },
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
          const Spacer(),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SaveButton(
                    title: "Confirm Appointment",
                    onTap: () async {
                      if (_dateController.text.isEmpty) {
                        showMessageBar("Appointment Date is Required", context);
                      } else if (_timeController.text.isEmpty) {
                        showMessageBar("Appointment Time is Required", context);
                      } else if (_endTimeController.text.isEmpty) {
                        showMessageBar(
                            "Appointment End Time is Required", context);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        String photoURL =
                            await StorageMethods().uploadImageToStorage(
                          'ProfilePics',
                          widget.uploadedDocument,
                        );
                        await FirebaseFirestore.instance
                            .collection("doctor_appointment")
                            .doc(uuid)
                            .set({
                          "paitientContact": widget.contactNumber,
                          "appointmentDate": _dateController.text.trim(),
                          "appointmentStartTime": _timeController.text.trim(),
                          "appointmentEndTime": _endTimeController.text.trim(),
                          "paitientName": widget.paitientName,
                          "paitientProblem": widget.paitientProblem,
                          "file": photoURL ?? "",
                          "doctorName": widget.doctorname,
                          "status": "confirm",
                          "price": int.parse(widget.price),
                          "paitientUid": FirebaseAuth.instance.currentUser!.uid,
                          "doctorId": widget.doctorUuid,
                          "appointmentId": uuid,
                          "paitientDate": widget.dob,
                          "gender": widget.gender
                        });
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => AppointmentRequestDone(
                                      type: widget.type,
                                    )));
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
