import 'package:estheva_web/uitls/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;

  final IconData? IconSuffix;
  final IconData? preFixICon;
  final TextInputType textInputType;
  VoidCallback? onTap;
  final int? maxlines;
  final int? maxLenght;

  TextFormInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      this.IconSuffix,
      this.preFixICon,
      required this.hintText,
      this.maxlines,
      this.maxLenght,
      this.onTap,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 60,
      child: TextField(
        maxLength: maxLenght,
        maxLines: maxlines,
        onTap: onTap,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          suffixIcon: Icon(
            IconSuffix,
            color: appColor,
          ),
          fillColor: Color(0xffF6F7F9),
          hintText: hintText,
          hintStyle: TextStyle(
            color: black,
            fontSize: 12,
            fontFamily: 'Futura',
          ),
          filled: true,
          contentPadding: EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
        inputFormatters: textInputType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null, // Apply input formatter only for number input type
        controller: controller,
        obscureText: isPass,
      ),
    );
  }
}
