import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/uitls/colors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            )),
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.workSans(
              color: white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 600,
                  width: 327,
                  child: Text(
                      "estheva_web respects your privacy.This Privacy Policy explains how estheva_web collects, uses, and discloses information from and about users '(you' or 'your') of our platform ('Platform'). We are committed to protecting your privacy and ensuring the security of your information. By using the Platform, you agree to the collection, use, and disclosure of information in accordance with this Privacy Policy. We may collect information you provide directly (like account information), information collected automatically (like device data), and information from third parties (like social media logins). We use this information to operate the Platform, provide services, personalize your experience, communicate with you, and improve our offerings. We may share your information with service providers and as required by law. We implement security measures to protect your information, but no website or internet transmission is completely secure. You can access, update, or delete your information through your account settings"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
