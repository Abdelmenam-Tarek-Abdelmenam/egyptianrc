import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../../resources/string_manager.dart';
import '../../../../shared/widget/buttons.dart';
import '../../../../shared/widget/loading_text.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStates>(
      builder: (context, state) {
        return AnimatedCrossFade(
            firstChild: const LoadingText(),
            secondChild: DefaultOutlinedButton(
              title: StringManger.logout,
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent());
              },
            ),
            crossFadeState: state.status == AuthStatus.loggingOut
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500));
      },
    );
  }
}
