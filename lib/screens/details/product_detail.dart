import 'package:flutter/material.dart';
import 'package:estheva_web/screens/details/product_booking.dart';
import 'package:estheva_web/uitls/colors.dart';

class ProductDetail extends StatefulWidget {
  final description;
  final discount;
  final photoURL;
  final uuid;
  final time;
  final price;
  final serviceCategory;
  final serviceName;
  final type;
  final serviceSubCategory;
  const ProductDetail(
      {super.key,
      required this.description,
      required this.discount,
      required this.photoURL,
      required this.time,
      required this.type,
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
            Image.network(
              widget.photoURL,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
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
            Padding(
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
                          widget.discount.toString(),
                          style: TextStyle(
                            fontFamily: 'Futura',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Use code SUMMER20 | above AED 10",
                          style: TextStyle(
                            fontFamily: 'Futura',
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
                    widget.price.toString() + "AED",
                    style: TextStyle(
                      fontFamily: 'Futura',
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
                              builder: (builder) => ProductBooking(
                                    time: widget.time,
                                    type: widget.type,
                                    price: widget.price.toString(),
                                    discount: widget.discount.toString(),
                                    description: widget.description,
                                    photoURL: widget.photoURL,
                                    serviceCategory: widget.serviceCategory,
                                    serviceName: widget.serviceName,
                                    serviceSubCategory:
                                        widget.serviceSubCategory,
                                    uuid: widget.uuid,
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
