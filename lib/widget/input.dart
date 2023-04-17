import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TiInput extends StatelessWidget {
  final double width;
  final double? height;
  final String hintText;
  final Color? hintColor;
  late String inputValue;

  late TextEditingController? inputController;
  final TextInputType keyboardType;
  final String icon;
  final Color color;
  final BoxBorder? border;
  late bool readonly = false;

  TiInput(
      {super.key,
      required this.color,
      required this.hintText,
      this.height,
      required this.icon,
      // required this.inputValue,
      this.inputController,
      this.hintColor,
      this.border,
      required this.keyboardType,
      required this.readonly,
      required this.width});

  @override
  Widget build(BuildContext context) {
    /*  late double height = MediaQuery.of(context).size.height;
    late double width = MediaQuery.of(context).size.width; */
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border:
              border, /* borderRadius: const BorderRadius.all(Radius.circular(25)) */
        ),
        child: TextField(
          readOnly: readonly,
          keyboardType: keyboardType,
          controller: inputController,
          
          style: GoogleFonts.poppins(color: Colors.white),
          // controller: _username,

          onChanged: ((value) {
            inputValue = value;
            print("Saisie__$inputValue")

                // username = value;
                /*  telephone_enter = value;
                      print("[+] Saisie : $telephone_enter") */
                ;
          }),
          decoration: InputDecoration(
              filled: true,
              fillColor: color,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                    width: 60,
                    margin: EdgeInsets.only(top: 3),
                    /* clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)), */
                    child: Text(
                      icon,
                      style: GoogleFonts.poppins(color: Colors.white),
                    )),
              ),
              // prefixIconColor: const Color.fromARGB(255, 248, 200, 24),
              // contentPadding: EdgeInsets.all(10),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 16, color: hintColor),
              enabledBorder: const OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
