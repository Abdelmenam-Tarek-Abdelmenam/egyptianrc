import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_status_bloc.dart';

import '../../../data/repositories/auth_repository.dart';

import '../../resources/routes_manger.dart';
import '../../resources/string_manager.dart';

import '../../shared/custom_scafffold/custom_scaffold.dart';
import '../../shared/widget/loading_text.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: StringManger.account,
        action: BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) {
            return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  AuthRepository.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                });
          },
        ),
        child: Expanded(
            child: Column(
          children: const [
            LoadingText(),
          ],
        )));
  }
}
