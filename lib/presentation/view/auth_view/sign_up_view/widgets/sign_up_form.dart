import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/sign_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        const SignTextField(
          isPassword: false,
          label: StringManger.name,
        ),
        SizedBox(height: 10.h),
        const SignTextField(
          isPassword: false,
          label: StringManger.mobilePhone,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 10.h),
        const SignTextField(
          isPassword: true,
          label: StringManger.password,
        ),
        SizedBox(height: 10.h),
        const SignTextField(
          isPassword: true,
          label: StringManger.password,
        ),
      ],
    ));
  }
}
