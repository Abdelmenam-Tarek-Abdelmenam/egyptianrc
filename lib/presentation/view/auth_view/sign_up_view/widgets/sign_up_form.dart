import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:egyptianrc/presentation/view/auth_view/shared/sign_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../../shared/widget/buttons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            SignTextField(
              controller: name,
              isPassword: false,
              label: StringManger.name,
            ),
            SizedBox(height: 10.h),
            SignTextField(
              isPassword: false,
              controller: phone,
              label: StringManger.mobilePhone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10.h),
            SignTextField(
              controller: pass1,
              isPassword: true,
              label: StringManger.password,
            ),
            SizedBox(height: 10.h),
            SignTextField(
              controller: pass2,
              isPassword: true,
              label: StringManger.password,
            ),
            SizedBox(height: 20.h),
            AnimatedCrossFade(
                firstChild: DefaultFilledButton(
                    label: StringManger.signup,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (pass1.text == pass2.text) {
                          context.read<AuthBloc>().add(RequestUserOtpEvent(
                              phone.text, pass1.text, name.text));
                        } else {
                          showToast(StringManger.twoPassError);
                        }
                      }
                    }),
                secondChild: const LoadingText(),
                crossFadeState: context.watch<AuthBloc>().state.status ==
                        AuthStatus.gettingOtp
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 500))
          ],
        ));
  }
}
