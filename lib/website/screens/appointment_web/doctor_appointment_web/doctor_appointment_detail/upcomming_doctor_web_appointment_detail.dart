import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpcommingDoctorWebAppointmentDetail extends StatefulWidget {
  final appointmentDate;
  final appointmentEndTime;
  final appointmentId;
  final appointmentStartTime;
  final doctorId;
  final doctorName;
  final file;
  final gender;
  final paitientName;
  final paitientDate;
  final paitientProblem;
  final paitientUid;
  final price;
  final status;
  const UpcommingDoctorWebAppointmentDetail(
      {super.key,
      required this.appointmentDate,
      required this.appointmentEndTime,
      required this.appointmentId,
      required this.appointmentStartTime,
      required this.doctorId,
      required this.doctorName,
      required this.file,
      required this.gender,
      required this.paitientDate,
      required this.paitientName,
      required this.paitientProblem,
      required this.paitientUid,
      required this.price,
      required this.status});

  @override
  State<UpcommingDoctorWebAppointmentDetail> createState() =>
      _UpcommingDoctorWebAppointmentDetailState();
}

class _UpcommingDoctorWebAppointmentDetailState
    extends State<UpcommingDoctorWebAppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                FormSelection(
                  appointmentDate: widget.appointmentDate,
                  appointmentEndTime: widget.appointmentEndTime,
                  appointmentId: widget.appointmentId,
                  appointmentStartTime: widget.appointmentStartTime,
                  doctorId: widget.doctorId,
                  doctorName: widget.doctorName,
                  paitientDate: widget.paitientDate,
                  paitientName: widget.paitientName,
                  paitientProblem: widget.paitientProblem,
                  paitientUid: widget.paitientUid,
                  price: widget.price.toString(),
                  file: widget.file,
                  gender: widget.gender,
                  status: widget.status,
                ),
                ImageSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSelection extends StatelessWidget {
  const ImageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logos.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}

class FormSelection extends StatelessWidget {
  final appointmentDate;
  final appointmentEndTime;
  final appointmentId;
  final appointmentStartTime;
  final doctorId;
  final doctorName;
  final file;
  final gender;
  final paitientName;
  final paitientDate;
  final paitientProblem;
  final paitientUid;
  final price;
  final status;
  const FormSelection(
      {super.key,
      required this.appointmentDate,
      required this.appointmentEndTime,
      required this.appointmentId,
      required this.appointmentStartTime,
      required this.doctorId,
      required this.doctorName,
      required this.file,
      required this.gender,
      required this.paitientDate,
      required this.paitientName,
      required this.paitientProblem,
      required this.paitientUid,
      required this.price,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
