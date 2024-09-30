import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/web_details.dart/product_booking_web.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailWeb extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final price;
  final serviceCategory;
  final serviceName;
  final serviceSubCategory;
  ProductDetailWeb(
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
  State<ProductDetailWeb> createState() => _ProductDetailWebState();
}

class _ProductDetailWebState extends State<ProductDetailWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                FormSection(
                  uuid: widget.uuid,
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

class FormSection extends StatelessWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final price;
  final serviceCategory;
  final serviceName;
  final serviceSubCategory;
  const FormSection(
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
  Widget build(BuildContext context) {
    return Container(
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              photoURL,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                serviceName,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
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
                          discount.toString(),
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
                    price.toString() + "AED",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Book now action
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ProductBookingWeb(
                                    description: description,
                                    discount: discount.toString(),
                                    price: price.toString(),
                                    serviceCategory: serviceCategory.toString(),
                                    uuid: uuid,
                                    serviceName: serviceName,
                                    serviceSubCategory: serviceSubCategory,
                                    photoURL: photoURL,
                                  )));
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
