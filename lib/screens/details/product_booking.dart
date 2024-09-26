import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/services/storage_methods.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProductBooking extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final price;
  final serviceCategory;
  final serviceName;
  final serviceSubCategory;
  ProductBooking(
      {super.key,
      required this.description,
      required this.discount,
      required this.photoURL,
      required this.price,
      required this.serviceCategory,
      required this.serviceName,
      required this.serviceSubCategory,
      required this.uuid});

  @override
  State<ProductBooking> createState() => _ProductBookingState();
}

class _ProductBookingState extends State<ProductBooking> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _contactControlelr = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor, // Change to the yellow color in the design
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/logos.png', // Replace with your logo asset path
          height: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Handle search button action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.photoURL,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.serviceName,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
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
                    style: GoogleFonts.manrope(
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
                    style: GoogleFonts.manrope(
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Number",
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: appColor),
                        ),
                        TextFormInputField(
                          preFixICon: Icons.numbers,
                          controller: _contactControlelr,
                          hintText: "Contact Number",
                          textInputType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SaveButton(
                      title: "Book Now",
                      onTap: () {
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
                                      showMessageBar(
                                          "Appointment Date is Required",
                                          context);
                                    } else if (_timeController.text.isEmpty) {
                                      showMessageBar(
                                          "Appointment Time is Required",
                                          context);
                                    } else if (_endTimeController
                                        .text.isEmpty) {
                                      showMessageBar(
                                          "Appointment End Time is Required",
                                          context);
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      String photoURL = await StorageMethods()
                                          .uploadImageToStorage(
                                        'ProfilePics',
                                        widget.photoURL,
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("doctor_appointment")
                                          .doc(widget.uuid)
                                          .set({
                                        "paitientContact":
                                            _contactControlelr.text.trim(),
                                        "appointmentDate":
                                            _dateController.text.trim(),
                                        "appointmentStartTime":
                                            _timeController.text.trim(),
                                        "appointmentEndTime":
                                            _endTimeController.text.trim(),
                                        "serviceName": widget.serviceName,
                                        "serviceCategory":
                                            widget.serviceCategory,
                                        "file": photoURL ?? "",
                                        "status": "confirm",
                                        "servicePhoto": photoURL,
                                        "price": int.parse(widget.price),
                                        "paitientUid": FirebaseAuth
                                            .instance.currentUser!.uid,
                                        "appointmentId": widget.uuid,
                                      });
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                      showMessageBar("Service Booked", context);
                                    }
                                  },
                                ),
                              );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
