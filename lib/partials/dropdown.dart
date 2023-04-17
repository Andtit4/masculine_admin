import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TiDropdown extends StatelessWidget {
  final String firstItem;
  final double width;
  final double height;
  final Color color;
  final Color borderColor;
  final void Function()? onPress;
  const TiDropdown(
      {super.key,
      required this.firstItem,
      required this.onPress,
      required this.width,
      required this.height,
      required this.borderColor,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              // border: Border.all(width: .1, color: borderColor),
              color: color,
              /* borderRadius: BorderRadius.circular(25) */),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                firstItem,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              Icon(Icons.arrow_downward, color: Colors.white)
            ],
          ),
        ));
  }
}
