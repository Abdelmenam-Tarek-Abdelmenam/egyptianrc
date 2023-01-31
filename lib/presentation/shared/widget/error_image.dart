import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage(this.url,
      {this.width, this.height, this.fit = BoxFit.cover, Key? key})
      : super(key: key);
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        width: 15,
        height: 15,
        child: SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(
              Icons.downloading,
              size: 30,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(
            Icons.error,
            size: 30,
          ),
        ),
      ),
    );
  }
}
