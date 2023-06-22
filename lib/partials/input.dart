import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  late double? width;
  late double? height;
  late TextEditingController? textEditingController;
  late Color? backgroundColor;
  late String? hintText;
  late Color? hintTextColor = Colors.white;
  late EdgeInsetsGeometry? contentPadding;
  late bool readOnly ;
  CustomInput(
      {super.key,
      this.width,
      this.height,
      this.textEditingController,
      this.backgroundColor,
      this.hintText,
      required this.readOnly,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        autocorrect: true,
        controller: textEditingController,
        style: GoogleFonts.poppins(color: Colors.white),
        cursorColor: hintTextColor,
        readOnly: readOnly,
        // cursorHeight: height,
        decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor,
            hintText: hintText,
            contentPadding: contentPadding,
            hintStyle: GoogleFonts.poppins(color: hintTextColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
