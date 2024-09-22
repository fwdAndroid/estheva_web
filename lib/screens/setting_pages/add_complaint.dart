import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/screens/main/main_dashboard.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/uitls/message_utils.dart';
import 'package:estheva_web/widgets/save_button.dart';
import 'package:uuid/uuid.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        title: Text(
          "Complaint",
          style: GoogleFonts.workSans(
              color: white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 13),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                hintText: "Complaint Title",
                fillColor: white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 13),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                hintText: "Enter Your Email",
                fillColor: Color(0xffF6F7F9),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 13),
            child: TextFormField(
              maxLines: 3,
              controller: descriptionController,
              decoration: InputDecoration(
                filled: true,
                hintText: "Write Your Issue",
                fillColor: Color(0xffF6F7F9),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : SaveButton(
                    title: "Submit",
                    onTap: () async {
                      if (titleController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        showMessageBar("All Fields are required", context);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        var uuid = Uuid().v4();
                        await FirebaseFirestore.instance
                            .collection("complains")
                            .doc(uuid)
                            .set({
                          "email": emailController.text.trim(),
                          "description": descriptionController.text.trim(),
                          "uid": FirebaseAuth.instance.currentUser!.uid,
                          "uuid": uuid,
                          "isSolved": false,
                          "title": titleController.text.trim()
                        });
                        setState(() {
                          isLoading = false;
                        });

                        showMessageBar("Complaint Submitted to admin", context);
                      }
                    },
                  ),
          )
        ],
      ),
    );
  }
}
