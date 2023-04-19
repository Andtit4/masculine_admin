import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  late double? width;
  late double? height;
  late Color? backgroundColor;
  late String? imgUrl;
  CustomCard(
      {super.key, this.backgroundColor, this.height, this.width, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imgUrl.toString(),
          ),
          Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.transparent, Colors.black])),
          )
        ],
      ),
    );
  }
}
