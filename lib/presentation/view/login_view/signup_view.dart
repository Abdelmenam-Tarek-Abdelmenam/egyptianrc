import 'package:flutter/material.dart';

import '../../../bloc/auth_bloc/auth_status_bloc.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final TextEditingController nameController =
      TextEditingController(text: AuthBloc.user.name);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(),
    );
  }
}
