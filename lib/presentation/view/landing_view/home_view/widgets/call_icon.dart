import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/customs_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../resources/string_manager.dart';
import '../../../../shared/toast_helper.dart';

class CallIcon extends StatelessWidget {
  const CallIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        const String phoneUrl = "tel://15322";
        if (await canLaunchUrl(Uri.parse(phoneUrl))) {
          await launchUrl(Uri.parse(phoneUrl));
        } else {
          showToast(StringManger.contactsErrors);
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(200.r, 200.r),
        shape: const CircleBorder(),
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: const CustomIcon(IconsManager.phone),
    );

    // return RawMaterialButton(
    //   elevation: 2,
    //   onPressed: () {
    //     print("fuck");
    //   },
    //   shape: const CircleBorder(),
    //   child: PhysicalModel(
    //     shape: BoxShape.circle,
    //     color: Colors.transparent,
    //     elevation: 5,
    //     shadowColor: Colors.black,
    //     child: Container(
    //         width: 200.r,
    //         height: 200.r,
    //         padding: EdgeInsets.all(50.r),
    //         decoration: BoxDecoration(
    //             color: ,
    //             shape: BoxShape.circle),
    //         child: ),
    //   ),
    // );
  }
}
