import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/view/auth_view/sign_up_view/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/routes_manger.dart';
import '../../../shared/custom_scafffold/custom_scaffold.dart';
import '../shared/sign_options.dart';
import '../shared/social_sign.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  StringManger.signup,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 10.h),
              const SignUpForm(),
              SizedBox(height: 20.h),
              const SocialSign(),
              const SignOptions(
                text2: StringManger.login,
                text1: StringManger.needHelp,
                route1: Routes.fastLogin,
                route2: Routes.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
