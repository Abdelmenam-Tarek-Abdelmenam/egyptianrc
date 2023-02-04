import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final bool validate;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const SignTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.validate = true,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),
      textAlign: TextAlign.right,
      obscureText: isPassword,
      validator: validate
          ? (txt) {
              if (txt!.isEmpty) {
                return "الحقل $label لا يمكن ان يكون فارغ ";
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.black,
              fontSize: 15.sp,
            ),
        errorStyle: TextStyle(
          fontSize: 12.sp,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
