import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/custom_scafffold/animated_splash.dart';
import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:egyptianrc/presentation/view/login_view/widgets/login_icons.dart';
import 'package:flutter/material.dart';

import '../../shared/on_will_pop.dart';
import '../../shared/widget/buttons.dart';

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
        child: SplashView(
          child: Column(
            children: [
              DefaultFilledButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.fastLogin),
                  title: StringManger.needHelp),
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
    );
  }
}
