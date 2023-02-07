import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhoto extends StatelessWidget {
  final String photoUrl;

  const ViewPhoto(this.photoUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Dismissible(
        background: Container(
          color: Colors.black,
        ),
        key: const Key('key'),
        direction: DismissDirection.down,
        onDismissed: (_) => Navigator.pop(context),
        child: Hero(
          tag: 'image',
          child: PhotoView(
            imageProvider: NetworkImage(photoUrl),
            loadingBuilder: (_, __) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (_, __, ___) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
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
