import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetail extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final price;
  final serviceCategory;
  final serviceName;
  final serviceSubCategory;
  const ProductDetail(
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
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedOption = 0; // For tracking selected radio button option
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/body.png"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Comprehensive Full Body Checkup",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Stool, urine test",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Results in 3-4 days",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.call, color: Colors.green, size: 30),
                    onPressed: () {
                      // WhatsApp button action
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Get the detailed check-up you deserve with this comprehensive premium test. Your test results will provide detailed information on the 90 biomarkers measured and whether levels are low, normal, or high. Together, these biomarkers offer a broad overview into the current status of your cholesterol, liver, kidneys, cardiac enzyme and...",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    title: Text(
                      "Standard - 500 ml",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "499.00 AED",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    title: Text(
                      "IV Glutathione + Vit C : 3 Sessions",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "1422.00 AED",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          color: Colors.orange.shade100,
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "5% OFF",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    title: Text(
                      "IV Glutathione + Vit C : 5 Sessions",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "2295.00 AED",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          color: Colors.orange.shade100,
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "8% OFF",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.yellow.shade100,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.discount, color: Colors.orange),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "20% Flat Discount",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Use code SUMMER20 | above AED 10",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "3036 AED",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Book now action
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (builder) => ProductBooking()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      "Book Now",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
