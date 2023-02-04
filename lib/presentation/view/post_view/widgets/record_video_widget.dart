import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/customs_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordImageIcon extends StatelessWidget {
  const RecordImageIcon(this.controller, {Key? key}) : super(key: key);
  final ValueNotifier<String?> controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'n',
      onPressed: () async {
        if (await Permission.camera.request().isGranted) {
          final ImagePicker picker = ImagePicker();
          picker.pickImage(source: ImageSource.camera).then((value) {
            if (value != null) {
              controller.value = value.path;
            }
          });
        }
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const CustomIcon(IconsManager.cam),
    );
  }
}
