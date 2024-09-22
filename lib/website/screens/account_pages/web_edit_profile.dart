import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebEditProfile extends StatelessWidget {
  const WebEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  TextEditingController customerFullNameContoller = TextEditingController();
  TextEditingController customerPhoneNumberController = TextEditingController();

  bool _isLoading = false;
  Uint8List? _image;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // Fetch data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched data
    setState(() {
      customerFullNameContoller.text = data['fullName'];
      customerPhoneNumberController.text = data['contactNumber'];
    });
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
            ),
            const SizedBox(height: 41),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: customerFullNameContoller,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Enter Full Name",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextFormField(
                controller: customerPhoneNumberController,
                style: GoogleFonts.plusJakartaSans(color: black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Enter Phone Number",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: mainColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SaveButton(
                          title: "Confirm",
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              "fullName": customerFullNameContoller.text.trim(),
                              "contactNumber":
                                  customerPhoneNumberController.text.trim(),
                            });
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.pop(context);
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

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
