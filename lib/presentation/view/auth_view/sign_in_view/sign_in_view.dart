import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/custom_scafffold/custom_scaffold.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/sign_options.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/social_sign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
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
            SizedBox(height: 20.h),
            const SocialSign(),
            const SignOptions(
              text2: StringManger.signup,
              text1: StringManger.needHelp,
              route1: Routes.fastLogin,
              route2: Routes.signup,
            ),
          ],
        ),
      ),
    );
  }
}
