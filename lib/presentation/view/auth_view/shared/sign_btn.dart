import 'package:egyptianrc/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final double width;
  const SignBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      this.height = 50,
      this.width = 300});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleManager.signBtnStyle.copyWith(
        fixedSize: MaterialStateProperty.all(
          Size(
            width.w,
            height.h,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
