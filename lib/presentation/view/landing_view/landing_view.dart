import 'package:egyptianrc/presentation/view/landing_view/widgets/record_sound_widget.dart';
import 'package:egyptianrc/presentation/view/landing_view/widgets/record_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HomeViewWidget()),
            )
          : CustomScaffold(
              title: StringManger.appName,
              action: action(context),
              child: const HomeViewWidget(),
            ),
    );
  }

  Widget action(BuildContext context) => BlocConsumer<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state.status == AuthStatus.finishSession) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.first, (route) => false);
          }
        },
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent());
              },
              icon: state.status == AuthStatus.loggingOut
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.logout));
        },
      );
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
          Text("اهلا بك يا ${AuthBloc.user.name ?? "الضيف"}",
              style: Theme.of(context).textTheme.headlineSmall),
          const RecordSoundWidget(),
          const RecordVideoWidget(),
        ],
      ),
    );
  }
}

enum HomePageStates { splash, landing }
