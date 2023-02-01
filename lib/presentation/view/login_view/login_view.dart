import 'package:flutter/material.dart';
import '../../resources/string_manager.dart';

import '../../shared/custom_scafffold/custom_scaffold.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringManger.login,
            style: Theme.of(context).textTheme.headlineLarge,
          )
        ],
      )),
    );
  }
}
