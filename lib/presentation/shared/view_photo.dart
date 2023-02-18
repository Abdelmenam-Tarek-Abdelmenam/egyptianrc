import 'package:flutter/material.dart';
// import 'dart:html';
import 'dart:ui' as ui;

class ViewPhoto extends StatelessWidget {
  final String photoUrl;

  const ViewPhoto(this.photoUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = photoUrl;
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    // ui.platformViewRegistry.registerViewFactory(
    //   imageUrl,
    //   (int _) => ImageElement()..src = imageUrl,
    // );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: HtmlElementView(
        viewType: imageUrl,
      ),
    );
  }

  // void saveImage(File file) async {
  //   EasyLoading.show(status: "saving...");
  //
  //   if (await Permission.storage.request().isGranted) {
  //     Directory? dir = await getExternalStorageDirectory();
  //     String newPath = "";
  //     List<String> folders = dir!.path.split("/");
  //     for (int x = 1; x < folders.length; x++) {
  //       if (folders[x] != 'Android') {
  //         newPath += "/" + folders[x];
  //       } else {
  //         break;
  //       }
  //     }
  //     newPath = newPath + "/Pharmacy APP";
  //     dir = Directory(newPath);
  //     if (await dir.exists()) {
  //       file.copy(newPath + "/${DateTime.now()}.jpeg").then((value) {
  //         EasyLoading.showInfo("file saved in Pharmacy APP file ");
  //       }).catchError((err) {
  //         EasyLoading.showError("an error Happened while saving");
  //       });
  //     } else {
  //       Directory(newPath).create().then((value) {
  //         file.copy(newPath + "/${DateTime.now()}.jpeg");
  //         EasyLoading.showInfo("file saved in Pharmacy APP file ");
  //       }).catchError((err) {
  //         EasyLoading.showError("an error Happened while saving");
  //       });
  //     }
  //   } else {
  //     EasyLoading.showError("Permission refused");
  //   }
  // }
}
