// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../shared/on_will_pop.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController1 = TextEditingController();
  final TextEditingController passController2 = TextEditingController();
  bool showPass1 = true;
  bool showPass2 = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showMyDialog(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Scaffold(),
      ),
    );
  }
}
