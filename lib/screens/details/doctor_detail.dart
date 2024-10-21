import 'package:estheva_web/screens/video/video_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/screens/appointments/appointment_begin.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/widgets/save_button.dart';

class DoctorDetail extends StatefulWidget {
  final experience;
  final name;
  final description;
  final uuid;
  final doctorCategory;
  final photo;
  final price;
  final type;
  DoctorDetail(
      {super.key,
      required this.description,
      required this.experience,
      required this.name,
      required this.doctorCategory,
      required this.photo,
      required this.type,
      required this.price,
      required this.uuid});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => VideoCall(
                              callingid: FirebaseAuth.instance.currentUser!.uid,
                              friendName: widget.name,
                            )));
              },
              icon: Icon(
                Icons.video_call,
                color: mainColor,
              ))
        ],
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
        backgroundColor: mainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.photo),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.41,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 17),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: appColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            widget.experience + " Years",
                            style: TextStyle(
                                fontFamily: 'Futura',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: appColor),
                          ),
                          Text(
                            "Experience",
                            style: TextStyle(
                                fontFamily: 'Futura',
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
                    style: TextStyle(
                        fontFamily: 'Futura',
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
                      widget.description,
                      style: TextStyle(
                          fontFamily: 'Futura',
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
                                style: TextStyle(
                                  fontFamily: 'Futura',
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
                                    " AED",
                                    style: TextStyle(
                                        fontFamily: 'Futura',
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    " " + widget.price.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Futura',
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "/Consultation fee",
                                    style: TextStyle(
                                      fontFamily: 'Futura',
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
                                builder: (builder) => AppointmentBegin(
                                      type: widget.type,
                                      name: widget.name,
                                      price: widget.price.toString(),
                                      photo: widget.photo,
                                      doctorCategory: widget.doctorCategory,
                                      experience: widget.experience,
                                      uuid: widget.uuid,
                                    )));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
