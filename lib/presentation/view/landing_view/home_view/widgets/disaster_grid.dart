import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/resources/styles_manager.dart';
import 'package:egyptianrc/presentation/resources/theme/theme_manager.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../resources/routes_manger.dart';
import '../../../user_view/post_disaster_view/post_disaster.dart';

class DisasterGrid extends StatelessWidget {
  DisasterGrid({Key? key}) : super(key: key);

  final List<DisasterGridItem> items = [
    DisasterGridItem(StringManger.accident, ColorManager.disaster1),
    DisasterGridItem(StringManger.fire, ColorManager.disaster2),
    DisasterGridItem(StringManger.explosion, ColorManager.disaster3),
    DisasterGridItem(StringManger.buildingFall, ColorManager.disaster4),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: items.map((e) => itemBuilder(context, e)).toList(),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, DisasterGridItem e) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: StyleManager.border,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(Routes.post, arguments: e);
            print(e.text);
          },
          child: Container(
            width: 150,
            height: 70,
            decoration: BoxDecoration(
                color: e.color.withOpacity(0.4),
                borderRadius: StyleManager.border),
            child: Center(
              child: Text(e.text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      );
}
