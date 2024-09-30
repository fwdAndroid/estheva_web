import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompleteDoctorAppointmentWeb extends StatefulWidget {
  const CompleteDoctorAppointmentWeb({super.key});

  @override
  State<CompleteDoctorAppointmentWeb> createState() =>
      _CompleteDoctorAppointmentWebState();
}

class _CompleteDoctorAppointmentWebState
    extends State<CompleteDoctorAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
    );
  }
}
