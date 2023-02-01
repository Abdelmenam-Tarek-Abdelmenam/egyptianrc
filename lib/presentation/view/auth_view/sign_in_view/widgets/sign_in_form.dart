import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/sign_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SignTextField(
            label: StringManger.mobilePhone,
            keyboardType: TextInputType.phone,
            isPassword: false,
          ),
          SizedBox(height: 15.h),
          const SignTextField(
            label: StringManger.password,
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
