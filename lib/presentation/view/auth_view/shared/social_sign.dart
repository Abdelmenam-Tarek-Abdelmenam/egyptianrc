import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../resources/styles_manager.dart';
import '../../../shared/widget/customs_icons.dart';

class SocialSign extends StatelessWidget {
  const SocialSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) {
            return IconButton(
              iconSize: 55.r,
              icon: CustomIcon(
                IconsManager.facebook,
                width: 55.w,
              ),
              onPressed: () => facebookIconCallback(context),
            );
          },
        ),
        SizedBox(width: 15.w),
        BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) {
            return state.status == AuthStatus.submittingGoogle
                ? const Padding(
                    padding: PaddingManager.p15,
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    iconSize: 45.r,
                    icon: CustomIcon(
                      IconsManager.google,
                      width: 45.w,
                    ),
                    onPressed: () => googleIconCallback(context),
                  );
          },
        ),
      ],
    );
  }

  void facebookIconCallback(BuildContext context) {}

  void googleIconCallback(BuildContext context) {
    context.read<AuthBloc>().add(LoginInUsingGoogleEvent());
  }
}
