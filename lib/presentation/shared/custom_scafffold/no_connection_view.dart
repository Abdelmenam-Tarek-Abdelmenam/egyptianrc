import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../resources/asstes_manager.dart';
import '../../view/landing_view/home_view/widgets/call_icon.dart';
import '../../view/landing_view/home_view/widgets/home_icon.dart';
import '../widget/customs_icons.dart';
import '../widget/dividers.dart';

const String phoneUrl = "tel://+201201838240";

class NoConnectionView extends StatelessWidget {
  const NoConnectionView(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? child
        : StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapShot) {
              Widget widget = noConnection(context);
              widget =
                  snapShot.data == ConnectivityResult.none ? widget : child;

              if (!snapShot.hasData) {
                FutureBuilder<ConnectivityResult>(
                    future: Connectivity().checkConnectivity(),
                    builder: (context, val) =>
                        val.data == ConnectivityResult.none
                            ? noConnection(context)
                            : child);
              }

              return widget;
            });
  }

  Widget noConnection(BuildContext context) => SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            upperIcons(context),
            Center(
              child: Column(
                children: [
                  Dividers.h30,
                  helpText(context),
                  Dividers.h10,
                  const CallIcon(),
                  Dividers.h20,
                ],
              ),
            ),
          ],
        ),
      ));

  Widget upperIcons(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeIcon(
            icon: const CustomIcon(IconsManager.message),
            onPressed: () {},
            active: AuthBloc.user.seen,
          ),
          const CustomIcon(IconsManager.call),
          HomeIcon(
            icon: const CustomIcon(IconsManager.notification),
            onPressed: () {},
            active: true,
          ),
        ],
      );

  Widget helpText(BuildContext context) => Column(
        children: [
          Text(
            StringManger.needHelpLong,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 24, fontWeight: FontWeight.w900, height: 1.25),
          ),
          Text(StringManger.clickHelp,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w900)),
        ],
      );
}
