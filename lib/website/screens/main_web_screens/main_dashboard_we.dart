import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_web/uitls/colors.dart';
import 'package:estheva_web/website/screens/product_web/product_detail_web.dart';
import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart'; // For the dots indicator
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/gestures.dart';

class MainDashboardWeb extends StatefulWidget {
  MainDashboardWeb({
    super.key,
  });

  @override
  State<MainDashboardWeb> createState() => _MainDashboardWebState();
}

class _MainDashboardWebState extends State<MainDashboardWeb> {
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  List<Map<String, String>> imgList = []; // To hold image URLs and titles
  String type = 'home';
  Future<Map<String, List<String>>> _fetchServices() async {
    final services = <String, List<String>>{};
    final querySnapshot = await FirebaseFirestore.instance
        .collection('services')
        .where('type', isEqualTo: type)
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

  void fetchImagesFromFirestore() async {
    // Replace 'your_collection' with the name of your Firestore collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('offers').get();

    List<Map<String, String>> fetchedImages = [];
    snapshot.docs.forEach((doc) {
      // Assuming the Firestore documents have 'imageUrl' and 'title' fields
      fetchedImages.add({
        'offerDetail': doc['offerDetail'],
        'photos': doc['photos'], // Title field
      });
    });

    setState(() {
      imgList = fetchedImages;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImagesFromFirestore();
  }

  void moveToNextPage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imgList.length;
    });
    _controller.animateToPage(
        _currentIndex); // Use animateToPage to go to the next image
  }

  void moveToPreviousPage() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1) < 0 ? imgList.length - 1 : _currentIndex - 1;
    });
    _controller.animateToPage(
        _currentIndex); // Use animateToPage to go to the previous image
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderBar(),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    // Carousel Slider
                    imgList.isNotEmpty
                        ? CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay:
                                  false, // Set autoPlay to false for manual navigation
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: imgList.map((item) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (builder) => WebOfferDetail(
                                  //               offerDetail:
                                  //                   item['offerDetail'],
                                  //               uuid: item['uuid'],
                                  //               photos: item['photos'],
                                  //             )));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(item['photos']!,
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
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: Text(
                                              item['offerDetail']!,
                                              style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Center(child: CircularProgressIndicator()),

                    Positioned(
                      left: 10,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.black,
                        onPressed: () {
                          moveToPreviousPage(); // Go to the previous page when left arrow is pressed
                        },
                      ),
                    ),

                    // Right arrow
                    Positioned(
                      right: 10,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        color: Colors.black,
                        onPressed: () {
                          moveToNextPage(); // Go to the next page when right arrow is pressed
                        },
                      ),
                    ),

                    // Indicator
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: imgList.isNotEmpty
                            ? DotsIndicator(
                                dotsCount: imgList.length,
                                position: _currentIndex,
                                decorator: DotsDecorator(
                                  activeColor: Colors.white,
                                  size: const Size.square(9.0),
                                  activeSize: const Size(18.0, 9.0),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              )
                            : Container(), // Return an empty container if imgList is empty
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'clinic',
                          groupValue: type,

                          // leading: Image.asset('assets/female.png',
                          //     width: 40, height: 40),
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/stethoscope-medical-tool.png",
                          filterQuality: FilterQuality.high,
                          height: 43,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Clinic Services",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Futura',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'home',
                          groupValue: type,

                          // leading:
                          //     Image.asset('assets/male.png', width: 40, height: 40),
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.home, size: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Home Services",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Futura',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Body Contouring Packages',
                  style: TextStyle(
                      fontFamily: 'Futura',
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance
                            .collection("services")
                            .where("serviceCategory",
                                isEqualTo: "Body Contouring Packages")
                            .where("type", isEqualTo: type)
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
                          return ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: ListView.builder(
                                itemCount: snap.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var serviceData = snap.docs[index].data();
                                  return SizedBox(
                                    width: 250,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    ProductDetailWeb(
                                                      time: serviceData['time'],
                                                      description: serviceData[
                                                          'serviceDescription'],
                                                      discount: serviceData[
                                                              'discount']
                                                          .toString(),
                                                      photoURL: serviceData[
                                                          'photoURL'],
                                                      uuid: serviceData['uuid'],
                                                      price:
                                                          serviceData['price']
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
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                child: Image.network(
                                                  height: 140,
                                                  width: 140,
                                                  fit: BoxFit.cover,
                                                  serviceData['photoURL'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 43,
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8, right: 8),
                                              child: Text(
                                                serviceData[
                                                    'serviceSubcategory'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: appColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
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
                                                        " AED",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Futura',
                                                        color: mainColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'IV Drips Therapy',
                  style: TextStyle(
                      color: appColor,
                      fontFamily: 'Futura',
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "IV Drips Therapy")
                          .where("type", isEqualTo: type)
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data()
                                  as Map<String, dynamic>;
                              return SizedBox(
                                width: 250,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ProductDetailWeb(
                                                  time: serviceData['time'],
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
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              height: 140,
                                              width: 140,
                                              fit: BoxFit.cover,
                                              serviceData['photoURL'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 43,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
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
                                                    " AED",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
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
                  style: TextStyle(
                      color: appColor,
                      fontSize: 16,
                      fontFamily: 'Futura',
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "IV Drips Therapy Packages")
                          .where("type", isEqualTo: type)
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data()
                                  as Map<String, dynamic>;
                              return SizedBox(
                                width: 250,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ProductDetailWeb(
                                                  time: serviceData['time'],
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
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              height: 140,
                                              width: 140,
                                              fit: BoxFit.cover,
                                              serviceData['photoURL'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 43,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
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
                                                    " AED",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
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
                  style: TextStyle(
                      color: appColor,
                      fontSize: 16,
                      fontFamily: 'Futura',
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory", isEqualTo: "Health Checkup")
                          .where("type", isEqualTo: type)
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data()
                                  as Map<String, dynamic>;
                              return SizedBox(
                                width: 250,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ProductDetailWeb(
                                                  time: serviceData['time'],
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
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              height: 140,
                                              width: 140,
                                              fit: BoxFit.cover,
                                              serviceData['photoURL'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 43,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
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
                                                    " AED",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
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
                  style: TextStyle(
                      color: appColor,
                      fontFamily: 'Futura',
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory", isEqualTo: "Physiotherapy")
                          .where("type", isEqualTo: type)
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data()
                                  as Map<String, dynamic>;
                              return SizedBox(
                                width: 250,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ProductDetailWeb(
                                                  time: serviceData['time'],
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
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              height: 140,
                                              width: 140,
                                              fit: BoxFit.cover,
                                              serviceData['photoURL'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 43,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
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
                                                    " AED",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              type == "clinic"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Aesthetic',
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              type == "clinic"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("services")
                                .where("serviceCategory",
                                    isEqualTo: "Aesthetic")
                                .where("type", isEqualTo: type)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                              return ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  },
                                ),
                                child: ListView.builder(
                                  itemCount: snap.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var serviceData = snap.docs[index].data()
                                        as Map<String, dynamic>;
                                    return SizedBox(
                                      width: 250,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ProductDetailWeb(
                                                        time:
                                                            serviceData['time'],
                                                        description: serviceData[
                                                            'serviceDescription'],
                                                        discount: serviceData[
                                                                'discount']
                                                            .toString(),
                                                        photoURL: serviceData[
                                                            'photoURL'],
                                                        uuid:
                                                            serviceData['uuid'],
                                                        price:
                                                            serviceData['price']
                                                                .toString(),
                                                        serviceCategory:
                                                            serviceData[
                                                                'serviceCategory'],
                                                        serviceName:
                                                            serviceData[
                                                                'serviceName'],
                                                        serviceSubCategory:
                                                            serviceData[
                                                                'serviceSubCategory'],
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  child: Image.network(
                                                    height: 140,
                                                    width: 140,
                                                    fit: BoxFit.cover,
                                                    serviceData['photoURL'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 43,
                                              width: 250,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8,
                                                    right: 8),
                                                child: Text(
                                                  serviceData[
                                                      'serviceSubcategory'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Futura',
                                                      color: appColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffD3D3D3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      serviceData['price']
                                                              .toString() +
                                                          " AED",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'Futura',
                                                          color: mainColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              type == "clinic"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hair Transplant',
                        style: TextStyle(
                            fontFamily: 'Futura',
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              type == "clinic"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("services")
                                .where("serviceCategory",
                                    isEqualTo: "Hair Transplant")
                                .where("type", isEqualTo: type)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                              return ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  },
                                ),
                                child: ListView.builder(
                                  itemCount: snap.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var serviceData = snap.docs[index].data()
                                        as Map<String, dynamic>;
                                    return SizedBox(
                                      width: 250,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ProductDetailWeb(
                                                        time:
                                                            serviceData['time'],
                                                        description: serviceData[
                                                            'serviceDescription'],
                                                        discount: serviceData[
                                                                'discount']
                                                            .toString(),
                                                        photoURL: serviceData[
                                                            'photoURL'],
                                                        uuid:
                                                            serviceData['uuid'],
                                                        price:
                                                            serviceData['price']
                                                                .toString(),
                                                        serviceCategory:
                                                            serviceData[
                                                                'serviceCategory'],
                                                        serviceName:
                                                            serviceData[
                                                                'serviceName'],
                                                        serviceSubCategory:
                                                            serviceData[
                                                                'serviceSubCategory'],
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  child: Image.network(
                                                    height: 140,
                                                    width: 140,
                                                    fit: BoxFit.cover,
                                                    serviceData['photoURL'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 43,
                                              width: 250,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8,
                                                    right: 8),
                                                child: Text(
                                                  serviceData[
                                                      'serviceSubcategory'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Futura',
                                                      color: appColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffD3D3D3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      serviceData['price']
                                                              .toString() +
                                                          " AED",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'Futura',
                                                          color: mainColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }
}
