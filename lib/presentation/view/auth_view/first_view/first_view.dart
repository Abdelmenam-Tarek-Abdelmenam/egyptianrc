import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/custom_scafffold/animated_splash.dart';
import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:egyptianrc/presentation/view/auth_view/sign_in_view/widgets/login_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/on_will_pop.dart';
import '../../../shared/widget/buttons.dart';

class FirstLoginView extends StatefulWidget {
  const FirstLoginView({Key? key}) : super(key: key);

  @override
  State<FirstLoginView> createState() => _FirstLoginViewState();
}

class _FirstLoginViewState extends State<FirstLoginView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showMyDialog(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<AuthBloc, AuthStates>(
          listener: (context, state) {
            if (state.status == AuthStatus.successSignUp) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.home, (_) => false);
            } else if (state.status == AuthStatus.successLogIn) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.home, (_) => false);
            } else if (state.status == AuthStatus.setOtp) {
              Navigator.of(context).pushNamed(Routes.otp);
            }
          },
          child: SplashView(
            child: Column(
              children: [
                DefaultFilledButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.fastLogin),
                    label: StringManger.needHelp),
                Dividers.h15,
                DefaultOutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.login),
                    title: StringManger.login),
                Dividers.h15,
                DefaultOutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.signup),
                    title: StringManger.signup),
                Dividers.h30,
                const LoginIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
