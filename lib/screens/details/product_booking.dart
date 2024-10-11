import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ProductBooking extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final type;
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
      required this.type,
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
  TextEditingController _paitientController = TextEditingController();
  bool isLoading = false;
  String? selectedDoctor; // For storing selected doctor
  List<String> doctorList = []; // For storing doctors list
  String _selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    fetchUsersDetails();
    fetchDoctors(); // Fetch doctors when the screen initializes
  }

  Future<void> fetchDoctors() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('doctorCategory', isEqualTo: widget.serviceName)
          .get();

      setState(() {
        doctorList = querySnapshot.docs
            .map((doc) => doc['doctorName'] as String)
            .toList();
      });
    } catch (e) {
      print('Error fetching doctors: $e');
      // Handle the error
    }
  }

  void fetchUsersDetails() async {
    // Fetch data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched data
    setState(() {
      _paitientController.text = data['fullName'];
      _contactControlelr.text =
          (data['contactNumber']); // Convert int to string
    });
  }

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
                style: TextStyle(
                  fontFamily: 'Futura',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  TextFormInputField(
                    preFixICon: Icons.person,
                    controller: _paitientController,
                    hintText: "Name",
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Aligning the radio buttons to the center
                    children: <Widget>[
                      // Male Radio Button
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
                        "Male",
                        style: TextStyle(
                          fontFamily: 'Futura',
                        ),
                      ),

                      // Female Radio Button
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
                        "Female",
                        style: TextStyle(
                          fontFamily: 'Futura',
                        ),
                      ),
                    ],
                  ),
                ],
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Number",
                          style: TextStyle(
                              fontFamily: 'Futura',
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Doctor",
                          style: TextStyle(
                              fontFamily: 'Futura',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: appColor),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedDoctor,
                          hint: Text(
                            "Choose a doctor",
                            style: TextStyle(
                              fontFamily: 'Futura',
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDoctor = newValue;
                            });
                          },
                          items: doctorList
                              .map<DropdownMenuItem<String>>((String doctor) {
                            return DropdownMenuItem<String>(
                              value: doctor,
                              child: Text(doctor),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SaveButton(
                          onTap: () async {
                            if (_paitientController.text.isEmpty) {
                              showMessageBar("User Name is required", context);
                            } else if (_dateController.text.isEmpty) {
                              showMessageBar(
                                  "Appointment Date is Required", context);
                            } else if (_timeController.text.isEmpty) {
                              showMessageBar(
                                  "Appointment Time is Required", context);
                            } else if (_endTimeController.text.isEmpty) {
                              showMessageBar(
                                  "Appointment End Time is Required", context);
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              var uuid = Uuid().v4();
                              await FirebaseFirestore.instance
                                  .collection("appointment")
                                  .doc(uuid)
                                  .set({
                                "gender": _selectedGender,
                                "patientName": _paitientController.text.trim(),
                                "doctorName": selectedDoctor,
                                "patientContact":
                                    _contactControlelr.text.trim(),
                                "appointmentDate": _dateController.text.trim(),
                                "appointmentStartTime":
                                    _timeController.text.trim(),
                                "appointmentEndTime":
                                    _endTimeController.text.trim(),
                                "serviceName": widget.serviceName,
                                "serviceCategory": widget.serviceCategory,
                                "serviceDescription": widget.description,
                                "status": "confirm",
                                "price": int.parse(widget.price),
                                "patientUid":
                                    FirebaseAuth.instance.currentUser!.uid,
                                "appointmentId": uuid,
                              });
                              setState(() {
                                isLoading = false;
                              });
                              showMessageBar("Service Booked", context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          MainDashboard(type: widget.type)));
                            }
                          },
                          title: "Book Now"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
