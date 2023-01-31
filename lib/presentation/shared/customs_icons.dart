import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(this.iconName, {this.width, this.color, Key? key})
      : super(key: key);
  final String iconName;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconName,
      width: width,
      color: color,
    );
  }
}
