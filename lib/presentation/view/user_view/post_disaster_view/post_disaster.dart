import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/view/user_view/widgets/camera_mic_btn.dart';
import 'package:egyptianrc/presentation/view/user_view/widgets/post_disaster_btn.dart';
import 'package:egyptianrc/presentation/view/user_view/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import '../../../resources/theme/theme_manager.dart';
//? should I use this or not? YEs yyou can use it

class PostDisasterView extends StatefulWidget {
  const PostDisasterView({super.key});

  @override
  State<PostDisasterView> createState() => _PostDisasterViewState();
}

class _PostDisasterViewState extends State<PostDisasterView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: CameraMicBtn(path: IconsManager.camera, color: ColorManager.darkColor),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: SearchBar(),
            ),
            const SizedBox(width: double.infinity),

            // TODO: check directionality of the app
            Padding(
              padding: EdgeInsets.only(bottom: 80.h, right: 20.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CameraMicBtn(
                    path: IconsManager.mic,
                    backgroundColor: ColorManager.whiteColor,
                    iconColor: ColorManager.blackColor,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  CameraMicBtn(
                    path: IconsManager.camera,
                    backgroundColor: ColorManager.darkColor,
                    iconColor: ColorManager.whiteColor,
                    onPressed: () {},
                  ),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:
                    PostDisasterBtn(onPressed: () {}, text: StringManger.post),
              ),
            ),
          ],
        ));
  }
}

//! Last EDIT : Yassin
//! Grades 9/10
