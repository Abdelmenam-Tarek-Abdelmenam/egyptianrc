import 'package:flutter/material.dart';

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
      onPressed: () => Navigator.of(context).pushNamed(Routes.user),
      icon: const Icon(Icons.person_outline_outlined));
}

class HomeViewWidget extends StatelessWidget {
  const HomeViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

enum HomePageStates { splash, landing }
