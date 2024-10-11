import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ServiceWidget extends StatelessWidget {
  VoidCallback onTap;
  String priceTitle;
  String descTitle;
  String department;
  String doctorName;
  String doctorPhoto;
  ServiceWidget(
      {super.key,
      required this.onTap,
      required this.department,
      required this.descTitle,
      required this.doctorName,
      required this.doctorPhoto,
      required this.priceTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              doctorPhoto,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Futura',
                    color: mainColor),
              ),
              Row(
                children: [
                  Text(
                    "Department: ",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    department,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Text(
                descTitle,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontFamily: 'Futura',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xff50555C)),
              )
            ],
          ),
          trailing: Text(
            priceTitle,
            style: TextStyle(
                fontFamily: 'Futura',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: mainColor),
          ),
        ),
      ),
    );
  }
}
