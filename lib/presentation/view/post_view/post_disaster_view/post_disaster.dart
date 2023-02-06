import 'dart:io';

import 'package:egyptianrc/data/data_sources/web_services/firestorage_repository.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../shared/widget/buttons.dart';
import '../../../shared/widget/dividers.dart';
import '../widgets/map_displayer.dart';
import '../widgets/record_image_widget.dart';
import '../widgets/record_sound_widget.dart';
//? should I use this or not? YEs yyou can use it

class PostDisasterView extends StatefulWidget {
  const PostDisasterView(this.type, {super.key});
  final DisasterGridItem type;

  @override
  State<PostDisasterView> createState() => _PostDisasterViewState();
}

class _PostDisasterViewState extends State<PostDisasterView> {
  final ValueNotifier<String?> audioFileController = ValueNotifier(null);
  final ValueNotifier<String?> imageFileController = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () async {
              print(audioFileController.value);
              if (audioFileController.value != null) {
                print("sending ...");
                print(audioFileController.value);
                String audioUrl = await FireStorageRepository().upload(
                    UploadFile(
                        type: FileType.record,
                        file: File(audioFileController.value!)));
                print("sent $audioUrl");
              }
              // print(imageFileController.value);

              // if (imageFileController.value != null) {
              //   print("sending ...");
              //   print(imageFileController.value);
              //   String audioUrl = await FireStorageRepository().upload(
              //       UploadFile(
              //           type: FileType.image,
              //           file: File(imageFileController.value!)));
              //   print("sent $audioUrl");
              // }
            },
          ),
        ),
      );
}

class DisasterGridItem {
  Color color;
  String text;

  DisasterGridItem(this.text, this.color);
}
