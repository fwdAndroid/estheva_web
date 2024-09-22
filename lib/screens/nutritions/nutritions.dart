import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/widgets/save_button.dart';

class Nutritions extends StatefulWidget {
  const Nutritions({super.key});

  @override
  State<Nutritions> createState() => _NutritionsState();
}

class _NutritionsState extends State<Nutritions> {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nutritions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/height.png"),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Enter Height',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _emailController,
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
                        hintText: "Enter Height",
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: black, fontSize: 12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SaveButton(title: "Next", onTap: () {}),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
