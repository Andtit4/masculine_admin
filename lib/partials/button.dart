import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  late double? width;
  late double? height;
  late Color? backgroundColor;
  late void Function()? onPress;
  late Widget? child;
  CustomButton(
      {super.key,
      this.onPress,
      this.backgroundColor,
      this.height,
      this.width,
      this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
