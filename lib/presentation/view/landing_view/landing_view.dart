import 'package:egyptianrc/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../resources/routes_manger.dart';
import '../../resources/string_manager.dart';

import '../../shared/custom_scafffold/animated_splash.dart';
import '../../shared/custom_scafffold/custom_scaffold.dart';
import '../../shared/on_will_pop.dart';

class LandingView extends StatelessWidget {
  const LandingView(this.state, {Key? key}) : super(key: key);
  final HomePageStates state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showMyDialog(context),
      child: state == HomePageStates.splash
          ? SplashView(
              title: StringManger.appName,
              action: action(context),
              child: const HomeViewWidget(),
            )
          : CustomScaffold(
              title: StringManger.appName,
              action: action(context),
              child: const HomeViewWidget(),
            ),
    );
  }

  Widget action(BuildContext context) => IconButton(
      onPressed: () {
        AuthRepository.signOut();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.first, (_) => false);
      },
      icon: const Icon(Icons.logout));
}

class HomeViewWidget extends StatelessWidget {
  const HomeViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "الصفحه الرئيسيه",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text("اهلا بك ${AuthBloc.user.name ?? "الضيف"}",
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}

enum HomePageStates { splash, landing }
