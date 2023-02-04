import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraMicBtn extends StatelessWidget {
  final String path;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;
  const CameraMicBtn({
    Key? key,
    required this.path,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50.r),
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: const CircleBorder(),
        ),
        child: IconButton(
          onPressed: onPressed,
          iconSize: 40.r,
          icon: SvgPicture.asset(
            path,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
