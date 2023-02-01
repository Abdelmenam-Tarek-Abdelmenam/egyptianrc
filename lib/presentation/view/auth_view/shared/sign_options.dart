import 'package:egyptianrc/presentation/resources/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/routes_manger.dart';

class SignOptions extends StatelessWidget {
  final String text1;
  final String text2;
  final String route1;
  final String route2;
  const SignOptions({
    super.key,
    required this.text1,
    required this.text2,
    required this.route1,
    required this.route2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(route1),
          child: Text(
            text1,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 14.sp, color: ColorManager.signBtnColor),
          ),
        ),
        Text('| ',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontSize: 14.sp, color: Colors.black)),
        TextButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(route2),
          child: Text(
            text2,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
          ),
        ),
      ],
    );
  }
}
