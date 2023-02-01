import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../../resources/string_manager.dart';

import '../../shared/social_sign.dart';

class LoginIcons extends StatelessWidget {
  const LoginIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(StringManger.continueWith,
            style: Theme.of(context).textTheme.headlineMedium),
        Dividers.h5,
        const SocialSign(),
      ],
    );
  }

  void facebookIconCallback(BuildContext context) {}

  void googleIconCallback(BuildContext context) {
    context.read<AuthBloc>().add(LoginInUsingGoogleEvent());
  }
}
