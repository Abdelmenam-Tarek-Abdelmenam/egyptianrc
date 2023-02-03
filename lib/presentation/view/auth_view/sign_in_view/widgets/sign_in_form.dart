import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../../shared/widget/buttons.dart';

import '../../shared/sign_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SignTextField(
            controller: phone,
            label: StringManger.mobilePhone,
            keyboardType: TextInputType.phone,
            isPassword: false,
          ),
          SizedBox(height: 15.h),
          SignTextField(
            controller: pass,
            label: StringManger.password,
            isPassword: true,
          ),
          SizedBox(height: 35.h),
          AnimatedCrossFade(
              firstChild: DefaultFilledButton(
                  label: StringManger.login,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String phoneNo = phone.text;
                      if (phoneNo.startsWith("+2")) {
                        phoneNo = phoneNo.substring(
                            phoneNo.length - 11, phoneNo.length);
                      }
                      phoneNo = "+2$phoneNo";
                      context.read<AuthBloc>().add(
                          LoginInUsingPhoneAndPassword(phoneNo, pass.text));
                    }
                  }),
              secondChild: const LoadingText(),
              crossFadeState: context.watch<AuthBloc>().state.status ==
                      AuthStatus.gettingUser
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500)),
        ],
      ),
    );
  }
}
