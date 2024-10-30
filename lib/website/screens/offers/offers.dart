import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/offers/offers_detail_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffersWeb extends StatefulWidget {
  const OffersWeb({super.key});

  @override
  State<OffersWeb> createState() => _OffersWebState();
}

class _OffersWebState extends State<OffersWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("offers")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Offers Avaiable'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                OfferDetailsWeb(
                                                  photo: serviceData['photos'],
                                                  uuid: serviceData['uuid'],
                                                  name: serviceData[
                                                      'offerDetail'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photos'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['offerDetail'],
                                          style: TextStyle(
                                              fontFamily: 'Futura',
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
