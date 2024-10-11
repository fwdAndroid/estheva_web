import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/web_details.dart/product_booking_web.dart';

import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.photoURL,
                height: 170,
                width: 500,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
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
            SizedBox(
                height: 300,
                width: 1200,
                child: Scrollbar(
                    // Add a scrollbar for the description
                    thumbVisibility: true, // Keep the scrollbar visible
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontFamily: 'Futura',
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ))),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Container(
            //     color: Colors.yellow.shade100,
            //     padding: EdgeInsets.all(16),
            //     child: Row(
            //       children: [
            //         Icon(Icons.discount, color: Colors.orange),
            //         SizedBox(width: 8),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               widget.discount.toString(),
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //               ),
            //             ),
            //             Text(
            //               "Use code SUMMER20 | above AED 10",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: Colors.black54,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.price.toString() + "AED",
                    style: TextStyle(
                      fontFamily: 'Futura',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Book now action
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ProductBookingWeb(
                                    description: widget.description,
                                    discount: widget.discount.toString(),
                                    price: widget.price.toString(),
                                    serviceCategory:
                                        widget.serviceCategory.toString(),
                                    uuid: widget.uuid,
                                    serviceName: widget.serviceName,
                                    serviceSubCategory:
                                        widget.serviceSubCategory,
                                    photoURL: widget.photoURL,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        fontFamily: 'Futura',
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
