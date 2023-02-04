import 'package:egyptianrc/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDisasterBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const PostDisasterBtn(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: StyleManager.signBtnStyle
          .copyWith(fixedSize: MaterialStateProperty.all(Size(300.w, 50.h))),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
