import 'package:egyptianrc/presentation/resources/asstes_manager.dart';

import 'package:egyptianrc/presentation/shared/widget/customs_icons.dart';
import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:egyptianrc/presentation/view/landing_view/home_view/widgets/call_icon.dart';
import 'package:egyptianrc/presentation/view/landing_view/home_view/widgets/disaster_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../resources/routes_manger.dart';
import '../../../resources/string_manager.dart';
import 'widgets/home_icon.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            upperIcons(context),
            Dividers.h30,
            helpText(context),
            Dividers.h10,
            const CallIcon(),
            Dividers.h20,
            Row(children: [
              Text(StringManger.nearHelp,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w100))
            ]),
            Dividers.h10,
            DisasterGrid()
          ],
        ),
      ),
    ));
  }

  Widget upperIcons(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeIcon(
            icon: const CustomIcon(IconsManager.message),
            onPressed: () => Navigator.of(context).pushNamed(Routes.chat),
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
                fontSize: 24.sp, fontWeight: FontWeight.w900, height: 1.25),
          ),
          Text(StringManger.clickHelp,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w900)),
        ],
      );
}
