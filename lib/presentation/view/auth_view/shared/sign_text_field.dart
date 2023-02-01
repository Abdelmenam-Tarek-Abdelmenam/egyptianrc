import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextInputType? keyboardType;
  const SignTextField({
    Key? key,
    required this.label,
    required this.isPassword,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      textAlign: TextAlign.right,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.black,
              fontSize: 15.sp,
            ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
