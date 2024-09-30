import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CancelDoctorAppointmentWeb extends StatefulWidget {
  const CancelDoctorAppointmentWeb({super.key});

  @override
  State<CancelDoctorAppointmentWeb> createState() =>
      _CancelDoctorAppointmentWebState();
}

class _CancelDoctorAppointmentWebState
    extends State<CancelDoctorAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
    );
  }
}
