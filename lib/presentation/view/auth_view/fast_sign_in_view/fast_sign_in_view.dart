import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/sign_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../shared/custom_scafffold/custom_scaffold.dart';
import '../../../shared/widget/buttons.dart';
import '../shared/social_sign.dart';
import '../shared/sign_text_field.dart';

class FastSignInView extends StatefulWidget {
  const FastSignInView({super.key});

  @override
  State<FastSignInView> createState() => _FastSignInViewState();
}

class _FastSignInViewState extends State<FastSignInView> {
  final TextEditingController phone = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
          child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35.h,
            ),
            Text(
              StringManger.fastLogin,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 35.h,
            ),
            SignTextField(
              controller: phone,
              label: StringManger.mobilePhone,
              isPassword: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 35.h,
            ),
            DefaultFilledButton(
              height: 45.h,
              width: 300.w,
              label: StringManger.needHelp,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(LoginInAsGuest(phone.text));
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                StringManger.continueWith,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14.sp,
                    ),
              ),
            ),
            const SocialSign(),
            SizedBox(
              height: 20.h,
            ),
            const SignOptions(
              text1: StringManger.signup,
              text2: StringManger.login,
              route1: Routes.signup,
              route2: Routes.login,
            ),
          ],
        ),
      )),
    );
  }
}
