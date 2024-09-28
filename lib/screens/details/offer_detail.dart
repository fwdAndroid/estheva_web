import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';

class OfferDetail extends StatefulWidget {
  final uuid;
  final offerDetail;
  final photos;
  const OfferDetail(
      {super.key,
      required this.offerDetail,
      required this.photos,
      required this.uuid});

  @override
  State<OfferDetail> createState() => _OfferDetailState();
}

class _OfferDetailState extends State<OfferDetail> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "Offers Detail",
          style: TextStyle(color: white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(widget.photos),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              height: 100,
              child: Text(
                widget.offerDetail,
                style: TextStyle(color: black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
