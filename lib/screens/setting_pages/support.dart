import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estheva_web/screens/setting_pages/add_complaint.dart';
import 'package:estheva_web/uitls/colors.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          child: Icon(
            Icons.add,
            color: white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => AddComplaint()));
          }),
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        title: Text(
          "Support",
          style: TextStyle(
              fontFamily: 'Futura',
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: mainColor,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("complains")
                .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No Complains Registered",
                    style: TextStyle(color: black),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    final Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title:  " + data['title'],
                              style: TextStyle(
                                fontFamily: 'Futura',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              data['description'],
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Futura',
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: data['isSolved'] == true
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () async {
                                        // Show the confirmation dialog
                                        bool? confirmDelete = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Delete"),
                                              content: Text(
                                                  "Are you sure you want to delete this item?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      fontFamily: 'Futura',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        false); // Return false when cancel is pressed
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      fontFamily: 'Futura',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        true); // Return true when delete is pressed
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        // If confirmDelete is true, proceed with deletion
                                        if (confirmDelete == true) {
                                          await FirebaseFirestore.instance
                                              .collection("complains")
                                              .doc(data['uuid'])
                                              .delete();
                                        }
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontFamily: 'Futura',
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
