import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/view/user_view/widgets/map_displayer.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/widget/buttons.dart';
import '../../../shared/widget/dividers.dart';
import '../widgets/record_image_widget.dart';
import '../widgets/record_sound_widget.dart';
//? should I use this or not? YEs yyou can use it

class PostDisasterView extends StatefulWidget {
  const PostDisasterView({super.key});

  @override
  State<PostDisasterView> createState() => _PostDisasterViewState();
}

class _PostDisasterViewState extends State<PostDisasterView> {
  late GoogleMapController mapController;
  final ValueNotifier<String?> audioFileController = ValueNotifier(null);
  final ValueNotifier<String?> imageFileController = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    audioFileController.value;
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RecordSoundWidget(audioFileController),
            Dividers.h10,
            RecordImageIcon(imageFileController),
          ],
        ),
        bottomNavigationBar: confirmWidget(),
        body: const MapDisplayer());
  }

  Widget confirmWidget() => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30)
              .copyWith(bottom: 20, right: 70),
          child: DefaultFilledButton(
            label: StringManger.post,
            onPressed: () {},
          ),
        ),
      );
}

//! Last EDIT : Yassin
//! Grades 9/10
