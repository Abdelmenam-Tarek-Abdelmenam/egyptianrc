import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/resources/theme/theme_manager.dart';

class CameraMicBtn extends StatelessWidget {
  String path;
  Color backgroundColor;
  Color iconColor;
  VoidCallback onPressed;
  CameraMicBtn({
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
