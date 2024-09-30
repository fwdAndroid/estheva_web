import 'package:estheva_web/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceAppointmentWeb extends StatefulWidget {
  const ServiceAppointmentWeb({super.key});

  @override
  State<ServiceAppointmentWeb> createState() => _ServiceAppointmentWebState();
}

class _ServiceAppointmentWebState extends State<ServiceAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(),
    );
  }
}
