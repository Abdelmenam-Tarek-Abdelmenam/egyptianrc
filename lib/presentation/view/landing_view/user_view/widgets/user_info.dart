import 'dart:math';

import 'package:egyptianrc/data/models/app_user.dart';
import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/customs_icons.dart';
import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  UserInfo(AppUser user, {super.key})
      : items = [
          InfoItem(
              label: StringManger.name,
              icon: IconsManager.profile,
              data: user.name,
              route: Routes.editName),
          InfoItem(
              label: StringManger.email,
              icon: IconsManager.email,
              data: user.email,
              route: Routes.editEmail),
          InfoItem(
              label: StringManger.password,
              icon: IconsManager.lock,
              data: List.filled(user.password?.length ?? 0, "*").join(""),
              route: Routes.editPassword),
          InfoItem(
              label: StringManger.address,
              icon: IconsManager.address,
              data: user.firstPlace,
              route: Routes.editAddress),
          InfoItem(
              label: StringManger.mobilePhone,
              icon: IconsManager.phoneNum,
              data: user.phoneNumber,
              route: Routes.editPhone),
        ];
  final List<InfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: items.map((e) => infoItemBuilder(context, e)).toList(),
      ),
    );
  }

  Widget infoItemBuilder(BuildContext context, InfoItem item) => ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(item.route);
        },
        minLeadingWidth: 10,
        leading: CustomIcon(item.icon),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: item.label,
              child: Text(
                item.label,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 14),
              ),
            ),
            Dividers.w10,
            Expanded(
              child: Text(
                item.data ?? "",
                maxLines: 1,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 14),
              ),
            )
          ],
        ),
        trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: const Icon(Icons.arrow_back_ios, size: 20)),
      );
}

class InfoItem {
  String label;
  String icon;
  String route;
  String? data;

  InfoItem(
      {required this.label,
      required this.icon,
      required this.route,
      this.data});
}
//   static const name = "الاسم";
//   static const email = "البريد الالكتروني";
//   static const password = "كلمة المرور";
//   static const mobilePhone = "رقم الهاتف";
//   static const address = "العنوان";
