import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../resources/asstes_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../shared/widget/customs_icons.dart';

class LoginIcons extends StatelessWidget {
  const LoginIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(StringManger.continueWith,
            style: Theme.of(context).textTheme.headlineMedium),
        Dividers.h5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AuthBloc, AuthStates>(
              builder: (context, state) {
                return IconButton(
                  iconSize: 55,
                  icon: const CustomIcon(
                    IconsManager.facebook,
                    width: 55,
                  ),
                  onPressed: () => facebookIconCallback(context),
                );
              },
            ),
            Dividers.w15,
            BlocBuilder<AuthBloc, AuthStates>(
              builder: (context, state) {
                return state.status == AuthStatus.submittingGoogle
                    ? const Padding(
                        padding: PaddingManager.p15,
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        iconSize: 45,
                        icon: const CustomIcon(
                          IconsManager.google,
                          width: 45,
                        ),
                        onPressed: () => googleIconCallback(context),
                      );
              },
            ),
          ],
        )
      ],
    );
  }

  void facebookIconCallback(BuildContext context) {}

  void googleIconCallback(BuildContext context) {
    context.read<AuthBloc>().add(LoginInUsingGoogleEvent());
  }
}
