import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  CustomImage(
    this.url, {
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      this.url,
      width: this.width,
      height: this.height,
      fit: this.fit,
    );
  }
}
