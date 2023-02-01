import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/styles_manager.dart';

class DefaultFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final double width;
  const DefaultFilledButton(
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

class DefaultOutlinedButton extends StatelessWidget {
  const DefaultOutlinedButton(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          fixedSize: Size(300.w, 50.h),
          side: BorderSide(
              width: 1.5, color: Theme.of(context).colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          textStyle: GoogleFonts.notoSansArabic(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        onPressed: onPressed,
        child: Text(title));
  }
}
