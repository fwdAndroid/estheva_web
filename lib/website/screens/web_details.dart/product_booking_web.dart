import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/website/web_checkout/web_checkoutpage.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:estheva_web/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:uuid/uuid.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class ProductBookingWeb extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final price;
  final serviceCategory;
  final serviceName;
  final serviceSubCategory;
  final time;
  const ProductBookingWeb(
      {super.key,
      required this.description,
      required this.discount,
      required this.photoURL,
      required this.price,
      required this.serviceCategory,
      required this.serviceName,
      required this.time,
      required this.serviceSubCategory,
      required this.uuid});

  @override
  State<ProductBookingWeb> createState() => _ProductBookingWebState();
}

class _ProductBookingWebState extends State<ProductBookingWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                FormSelection(
                  uuid: widget.uuid,
                  time: widget.time,
                  serviceSubCategory: widget.serviceSubCategory,
                  serviceName: widget.serviceName,
                  serviceCategory: widget.serviceCategory,
                  discount: widget.discount.toString(),
                  description: widget.description,
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

class FormSelection extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final price;
  final time;
  final serviceCategory;
  final serviceName;
  final serviceSubCategory;
  const FormSelection(
      {super.key,
      required this.description,
      required this.discount,
      required this.photoURL,
      required this.price,
      required this.serviceCategory,
      required this.serviceName,
      required this.serviceSubCategory,
      required this.time,
      required this.uuid});

  @override
  State<FormSelection> createState() => _FormSelectionState();
}

class _FormSelectionState extends State<FormSelection> {
  TextEditingController _contactControlelr = TextEditingController();
  TextEditingController _paitientController = TextEditingController();

  DateTime? _selectedValue;
  String? _selectedTime;
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
          // .where('doctorCategory', isEqualTo: widget.serviceName)
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
    return Container(
      width: 460,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.photoURL),
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
                    "Total Service Time",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appColor),
                  ),
                  Text(
                    "Service Time: " + widget.time,
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: appColor),
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
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
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
                          hint: Text("Choose a doctor"),
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
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              var uuid = Uuid().v4();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => CheckOutPageWeb(
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
                                                _contactControlelr.text.trim(),
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
