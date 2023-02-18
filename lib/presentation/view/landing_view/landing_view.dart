import 'package:egyptianrc/bloc/home_bloc/home_bloc.dart';
import 'package:egyptianrc/presentation/shared/custom_scafffold/no_connection_view.dart';
import 'package:egyptianrc/presentation/view/landing_view/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_status_bloc.dart';

import '../../resources/routes_manger.dart';
import '../../shared/on_will_pop.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showMyDialog(context),
      child: BlocListener<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state.status == AuthStatus.finishSession) {
            context.read<HomeBloc>().add(ChangeHomePage(0));
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.first, (route) => false);
          }
        },
        child: Scaffold(
          bottomNavigationBar: const HomeBottomBar(),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: NoConnectionView(context.watch<HomeBloc>().state.toWidget()),
          ),
        ),
      ),
    );
  }
}
