import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  CustomImage(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
