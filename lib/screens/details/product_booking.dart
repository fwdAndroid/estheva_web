import 'package:estheva_web/screens/details/mobile_checkout.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
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
  final time;

  ProductBooking(
      {required this.serviceName,
      required this.photoURL,
      required this.description,
      required this.discount,
      required this.time,
      required this.price,
      required this.type,
      required this.serviceCategory,
      required this.serviceSubCategory,
      required this.uuid});

  @override
  _ProductBookingState createState() => _ProductBookingState();
}

class _ProductBookingState extends State<ProductBooking> {
  TextEditingController _contactController = TextEditingController();
  TextEditingController _paitientController = TextEditingController();
  bool isLoading = false;
  String? selectedDoctor;
  List<String> doctorList = [];
  String _selectedGender = 'male';
  DateTime? _selectedValue;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    fetchDoctors();
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
    }
  }

  void fetchUserDetails() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    setState(() {
      _paitientController.text = data['fullName'];
      _contactController.text = data['contactNumber'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/logos.png',
          height: 30,
        ),
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
                  SizedBox(
                    height: 100,
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.black,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          _selectedValue = date;
                          print(_selectedValue.toString());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedValue != null) _buildTimeDropdown(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          controller: _contactController,
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
                            } else if (_selectedTime!.isEmpty) {
                              showMessageBar("Time is Not Selected", context);
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              var uuid = Uuid().v4();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MobileCheckout(
                                            gender: _selectedGender,
                                            serviceDescription:
                                                widget.description,
                                            status: "confirm",
                                            price: widget.price,
                                            patientUid: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            doctorName: selectedDoctor,
                                            appointmentStartTime:
                                                _selectedTime.toString(),
                                            appointmentServiceTime: widget.time,
                                            appointmentId: uuid,
                                            patientName:
                                                _paitientController.text.trim(),
                                            serviceName: widget.serviceName,
                                            patientContact:
                                                _contactController.text.trim(),
                                            serviceCategory:
                                                widget.serviceCategory,
                                            appointmentDate:
                                                _selectedValue.toString(),
                                          )));

                              setState(() {
                                isLoading = false;
                              });
                              // showMessageBar("Service Booked", context);
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

  Widget _buildTimeDropdown() {
    List<String> timeSlots =
        List.generate(24, (index) => '${index.toString().padLeft(2, '0')}:00');

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Appointment Time",
            style: TextStyle(
                fontFamily: 'Futura',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: appColor),
          ),
          DropdownButtonFormField<String>(
            value: _selectedTime,
            hint: Text("Choose a time"),
            onChanged: (String? newValue) {
              setState(() {
                _selectedTime = newValue;
              });
            },
            items: timeSlots.map<DropdownMenuItem<String>>((String time) {
              return DropdownMenuItem<String>(
                value: time,
                child: Text(time),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
