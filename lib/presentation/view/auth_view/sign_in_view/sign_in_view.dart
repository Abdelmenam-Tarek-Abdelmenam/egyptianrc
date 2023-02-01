import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/custom_scafffold/custom_scaffold.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/sign_btn.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/sign_options.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/social_sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          SizedBox(
            height: 35.h,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              StringManger.login,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SignInForm(),
          SizedBox(height: 35.h),
          SignBtn(label: StringManger.login, onPressed: () {}),
          SizedBox(height: 20.h),
          const SocialSign(),
          const SignOptions(
            text2: StringManger.signup,
            text1: StringManger.needHelp,
          ),
        ],
      ),
    );
  }
}
