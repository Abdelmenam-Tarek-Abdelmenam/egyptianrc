import 'dart:io';
import 'dart:typed_data';

import 'package:egyptianrc/data/error_state.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FireStorageRepository {
  final _storageRef = FirebaseStorage.instance.ref();

  Future<String> upload(UploadFile file) async {
    final fileRef = _storageRef.child(file.refName);
    try {
      // final task = fileRef.putFile(file.file); //This task give some methods
      await fileRef.putFile(
          file.file, SettableMetadata(contentType: file.type.extension));

      String url = await fileRef.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(e.message ?? StringManger.defaultError);
    } catch (err) {
      throw const Failure();
    }
  }

  Future<UploadFile?> download(String url) async {
    try {
      final fileReference = FirebaseStorage.instance.refFromURL(url);
      Uint8List? data = await fileReference.getData();
      FullMetadata metadata = await fileReference.getMetadata();
      if (data != null) {
        FileType fileType = FileType.fromContent(metadata.contentType);
        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/${metadata.name}').create();
        file.writeAsBytesSync(data);
        return UploadFile(file: file, type: fileType);
      }
      return null;
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? StringManger.defaultError);
    } catch (err) {
      throw const Failure();
    }
  }
}

class UploadFile {
  File file;
  FileType type;

  UploadFile({required this.file, required this.type});

  String get name => DateTime.now().toString() + type.extension;

  String get refName => type.toString() + name;
}

enum FileType {
  image,
  video,
  record,
  none;

  static FileType fromContent(String? contentType) {
    switch (contentType) {
      case "jpg":
        return FileType.image;
      case "mp4":
        return FileType.video;
      case "mp3":
        return FileType.record;
      default:
        return FileType.none;
    }
  }

  @override
  String toString() {
    switch (this) {
      case FileType.image:
        return "images/";
      case FileType.video:
        return "videos/";
      case FileType.record:
        return "records/";
      default:
        return "";
    }
  }

  String get extension {
    switch (this) {
      case FileType.image:
        return ".jpg";
      case FileType.video:
        return ".mp4";
      case FileType.record:
        return ".mp3";
      default:
        return "";
    }
  }
}
