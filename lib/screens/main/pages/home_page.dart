import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/screens/details/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:estheva_web/uitls/colors.dart';

class HomePage extends StatefulWidget {
  String type;
  HomePage({super.key, required this.type});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, List<String>>> _fetchServices() async {
    final services = <String, List<String>>{};
    final querySnapshot = await FirebaseFirestore.instance
        .collection('services')
        .where('type', isEqualTo: widget.type)
        .get();

    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final category = data['category'] as String;
      final subCategory = data['subCategory'] as String;

      if (services[category] == null) {
        services[category] = [];
      }
      services[category]!.add(subCategory);
    }

    return services;
  }

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408350-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f35b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Search Services"),
          ),
          leading: Image.asset("assets/logos.png"),
        ),
        endDrawer: Drawer(),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: imgList
                      .map((item) => Container(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(item,
                                          fit: BoxFit.cover, width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Text(
                                            'No. ${imgList.indexOf(item)} image',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ))
                      .toList(),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Body Contouring Packages',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "Body Contouring Packages")
                          .where("type", isEqualTo: widget.type)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
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
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
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
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'IV Drips Therapy',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("services")
                        .where("serviceCategory", isEqualTo: "IV Drips Therapy")
                        .where("type", isEqualTo: widget.type)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No Service available',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }

                      var snap = snapshot.data!;
                      return ListView.builder(
                        itemCount: snap.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var serviceData =
                              snap.docs[index].data() as Map<String, dynamic>;
                          return SizedBox(
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => ProductDetail(
                                              description: serviceData[
                                                  'serviceDescription'],
                                              discount: serviceData['discount']
                                                  .toString(),
                                              photoURL: serviceData['photoURL'],
                                              uuid: serviceData['uuid'],
                                              price: serviceData['price']
                                                  .toString(),
                                              serviceCategory: serviceData[
                                                  'serviceCategory'],
                                              serviceName:
                                                  serviceData['serviceName'],
                                              serviceSubCategory: serviceData[
                                                  'serviceSubCategory'],
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        height: 80,
                                        width: 90,
                                        fit: BoxFit.cover,
                                        serviceData['photoURL'],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8, right: 8),
                                    child: Text(
                                      serviceData['serviceSubcategory'],
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffD3D3D3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          serviceData['price'].toString() +
                                              "AED",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'IV Drips Therapy Packages',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("services")
                        .where("serviceCategory",
                            isEqualTo: "IV Drips Therapy Packages")
                        .where("type", isEqualTo: widget.type)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No Service available',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }

                      var snap = snapshot.data!;
                      return ListView.builder(
                        itemCount: snap.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var serviceData =
                              snap.docs[index].data() as Map<String, dynamic>;
                          return SizedBox(
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => ProductDetail(
                                              description: serviceData[
                                                  'serviceDescription'],
                                              discount: serviceData['discount']
                                                  .toString(),
                                              photoURL: serviceData['photoURL'],
                                              uuid: serviceData['uuid'],
                                              price: serviceData['price']
                                                  .toString(),
                                              serviceCategory: serviceData[
                                                  'serviceCategory'],
                                              serviceName:
                                                  serviceData['serviceName'],
                                              serviceSubCategory: serviceData[
                                                  'serviceSubCategory'],
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        height: 80,
                                        width: 90,
                                        fit: BoxFit.cover,
                                        serviceData['photoURL'],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8, right: 8),
                                    child: Text(
                                      serviceData['serviceSubcategory'],
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffD3D3D3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          serviceData['price'].toString() +
                                              "AED",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Health Checkup',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("services")
                        .where("serviceCategory", isEqualTo: "Health Checkup")
                        .where("type", isEqualTo: widget.type)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No Service available',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }

                      var snap = snapshot.data!;
                      return ListView.builder(
                        itemCount: snap.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var serviceData =
                              snap.docs[index].data() as Map<String, dynamic>;
                          return SizedBox(
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => ProductDetail(
                                              description: serviceData[
                                                  'serviceDescription'],
                                              discount: serviceData['discount']
                                                  .toString(),
                                              photoURL: serviceData['photoURL'],
                                              uuid: serviceData['uuid'],
                                              price: serviceData['price']
                                                  .toString(),
                                              serviceCategory: serviceData[
                                                  'serviceCategory'],
                                              serviceName:
                                                  serviceData['serviceName'],
                                              serviceSubCategory: serviceData[
                                                  'serviceSubCategory'],
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        height: 80,
                                        width: 90,
                                        fit: BoxFit.cover,
                                        serviceData['photoURL'],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8, right: 8),
                                    child: Text(
                                      serviceData['serviceSubcategory'],
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffD3D3D3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          serviceData['price'].toString() +
                                              "AED",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Physiotherapy',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("services")
                        .where("serviceCategory", isEqualTo: "Physiotherapy")
                        .where("type", isEqualTo: widget.type)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No Service available',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }

                      var snap = snapshot.data!;
                      return ListView.builder(
                        itemCount: snap.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var serviceData =
                              snap.docs[index].data() as Map<String, dynamic>;
                          return SizedBox(
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => ProductDetail(
                                              description: serviceData[
                                                  'serviceDescription'],
                                              discount: serviceData['discount']
                                                  .toString(),
                                              photoURL: serviceData['photoURL'],
                                              uuid: serviceData['uuid'],
                                              price: serviceData['price']
                                                  .toString(),
                                              serviceCategory: serviceData[
                                                  'serviceCategory'],
                                              serviceName:
                                                  serviceData['serviceName'],
                                              serviceSubCategory: serviceData[
                                                  'serviceSubCategory'],
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        height: 80,
                                        width: 90,
                                        fit: BoxFit.cover,
                                        serviceData['photoURL'],
                                      ),
                                    ),
                                  ),
                                  // Image.network(
                                  //   serviceData['photoURL'],
                                  //   width: MediaQuery.of(context).size.width,
                                  //   height: 75,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8, right: 8),
                                    child: Text(
                                      serviceData['serviceSubcategory'],
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffD3D3D3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          serviceData['price'].toString() +
                                              "AED",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.type == "clinic"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Aesthetic',
                        style: GoogleFonts.poppins(
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              widget.type == "clinic"
                  ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 165,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("services")
                              .where("serviceCategory", isEqualTo: "Aesthetic")
                              .where("type", isEqualTo: widget.type)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData ||
                                snapshot.data == null ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Service available',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }

                            var snap = snapshot.data!;
                            return ListView.builder(
                              itemCount: snap.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var serviceData = snap.docs[index].data()
                                    as Map<String, dynamic>;
                                return SizedBox(
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ProductDetail(
                                                    description: serviceData[
                                                        'serviceDescription'],
                                                    discount:
                                                        serviceData['discount']
                                                            .toString(),
                                                    photoURL:
                                                        serviceData['photoURL'],
                                                    uuid: serviceData['uuid'],
                                                    price: serviceData['price']
                                                        .toString(),
                                                    serviceCategory:
                                                        serviceData[
                                                            'serviceCategory'],
                                                    serviceName: serviceData[
                                                        'serviceName'],
                                                    serviceSubCategory:
                                                        serviceData[
                                                            'serviceSubCategory'],
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
                                              serviceData['photoURL'],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffD3D3D3),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                serviceData['price']
                                                        .toString() +
                                                    "AED",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              widget.type == "clinic"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hair Transplant',
                        style: GoogleFonts.poppins(
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              widget.type == "clinic"
                  ? Container(
                      margin: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 165,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("services")
                              .where("serviceCategory",
                                  isEqualTo: "Hair Transplant")
                              .where("type", isEqualTo: widget.type)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData ||
                                snapshot.data == null ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Service available',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }

                            var snap = snapshot.data!;
                            return ListView.builder(
                              itemCount: snap.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var serviceData = snap.docs[index].data()
                                    as Map<String, dynamic>;
                                return SizedBox(
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ProductDetail(
                                                    description: serviceData[
                                                        'serviceDescription'],
                                                    discount:
                                                        serviceData['discount']
                                                            .toString(),
                                                    photoURL:
                                                        serviceData['photoURL'],
                                                    uuid: serviceData['uuid'],
                                                    price: serviceData['price']
                                                        .toString(),
                                                    serviceCategory:
                                                        serviceData[
                                                            'serviceCategory'],
                                                    serviceName: serviceData[
                                                        'serviceName'],
                                                    serviceSubCategory:
                                                        serviceData[
                                                            'serviceSubCategory'],
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
                                              serviceData['photoURL'],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffD3D3D3),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                serviceData['price']
                                                        .toString() +
                                                    "AED",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }
}
