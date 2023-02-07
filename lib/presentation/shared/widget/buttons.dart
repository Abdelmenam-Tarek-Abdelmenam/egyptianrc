import 'package:egyptianrc/bloc/location_bloc/location_bloc.dart';
import 'package:egyptianrc/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return ElevatedButton(
          style: state.status != BlocStatus.getData
              ? StyleManager.signBtnStyle.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey,
                  ),
                  fixedSize: MaterialStateProperty.all(
                    Size(width.w, height.h),
                  ),
                )
              : StyleManager.signBtnStyle.copyWith(
                  fixedSize: MaterialStateProperty.all(
                    Size(width.w, height.h),
                  ),
                ),
          onPressed: state.status == BlocStatus.getData ? onPressed : null,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        );
      },
    );
  }
}

class DefaultOutlinedButton extends StatelessWidget {
  const DefaultOutlinedButton(
      {required this.title,
      required this.onPressed,
      this.height = 50,
      this.width = 300,
      Key? key})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          fixedSize: Size(width.w, height.h),
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
