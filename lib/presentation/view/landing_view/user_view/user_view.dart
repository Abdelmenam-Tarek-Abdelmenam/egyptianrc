import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../shared/widget/loading_text.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<AuthBloc, AuthStates>(
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
          ),
        ],
      ),
    ));
  }
}
