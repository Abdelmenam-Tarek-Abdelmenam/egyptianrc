import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/data/models/app_user.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/resources/theme/theme_manager.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/widgets/avatar.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/widgets/logout_button.dart';
import 'package:egyptianrc/presentation/view/landing_view/user_view/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/widget/dividers.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorManager.mainColor.withOpacity(0),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = AuthBloc.user;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userImage(context, user.photoUrl),
          infoText(context, user.name, user.email),
          Dividers.h10,
          UserInfo(user),
          Dividers.h30,
          const LogOutButton(),
        ],
      ),
    );
  }

  Widget userImage(BuildContext context, String? photoUrl) => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: 110.r,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.r),
            child: Avatar(photoUrl, 100.r),
          ),
        ],
      );

  Widget infoText(BuildContext context, String? name, String? email) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            FittedBox(
              child: Text(
                name ?? StringManger.guest,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w900),
              ),
            ),
            Text(email ?? StringManger.noEmail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w200,
                    height: 1.25)),
          ],
        ),
      );
}
