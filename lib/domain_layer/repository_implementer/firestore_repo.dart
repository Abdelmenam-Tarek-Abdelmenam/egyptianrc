import 'package:egyptianrc/data/data_sources/web_services/firestore_repository.dart';
import 'package:egyptianrc/data/error_state.dart';
import 'package:either_dart/either.dart';

import '../../data/models/app_user.dart';
import '../../data/models/disaster_post.dart';

class DatabaseRepo {
  final FireStoreRepository _repository = FireStoreRepository();

  void addListener(Function(List<DisasterPost>) callback) {
    _repository.buildListener(
        (data) => callback(data.map((e) => DisasterPost.fromMap(e)).toList()));
  }

  Future<Either<Failure, void>> setArchivePost(DisasterPost post) async {
    try {
      await _repository.setArchivePost(post.toMap());
      await _repository.deleteActivePost(post.postId);
      return const Right(null);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء نعديل بيانات المستخدم"));
    }
  }

  Future<Either<Failure, void>> editUser(AppUser user) async {
    try {
      Map<String, dynamic> data = user.toJson;
      await _repository.updateUserInfo(data);
      return const Right(null);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء نعديل بيانات المستخدم"));
    }
  }

  Future<Either<Failure, void>> postDisaster(DisasterPost post) async {
    try {
      Map<String, dynamic> data = post.toMap();
      await _repository.updateUserInfo(data);
      return const Right(null);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء نعديل بيانات المستخدم"));
    }
  }

  Future<Either<Failure, DisasterHolder>> readDisasters(
      Map<String, String> ids) async {
    try {
      DisasterHolder holder = DisasterHolder();
      for (String id in ids.keys) {
        Map<String, dynamic>? data = await _repository.getPost(id, ids[id]!);
        if (data != null) {
          if (ids[id] == archiveColl) {
            holder.addActive(DisasterPost.fromMap(data));
          } else {
            holder.addArchive(DisasterPost.fromMap(data));
          }
        }
      }
      return Right(DisasterHolder());
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء نعديل بيانات المستخدم"));
    }
  }

  Future<Either<Failure, List<DisasterPost>>> getActiveDisasters() async {
    try {
      List<Map<String, dynamic>> data = await _repository.readAllActivePosts();
      List<DisasterPost> posts =
          data.map((e) => DisasterPost.fromMap(e)).toList();
      return Right(posts);
    } catch (_, trace) {
      print(_);
      print(trace);
      return const Left(Failure("حدث خطأ اثناء الحصول علي البيانات"));
    }
  }

  Future<Either<Failure, List<DisasterPost>>> getArchiveDisasters() async {
    try {
      List<Map<String, dynamic>> data = await _repository.readAllArchivePosts();
      List<DisasterPost> posts =
          data.map((e) => DisasterPost.fromMap(e)).toList();
      return Right(posts);
    } catch (_, trace) {
      print(_);
      print(trace);
      return const Left(Failure("حدث خطأ اثناء الحصول علي البيانات"));
    }
  }
}

class DisasterHolder {
  List<DisasterPost> archived = [];
  List<DisasterPost> active = [];

  void addArchive(DisasterPost post) => archived.add(post);
  void addActive(DisasterPost post) => active.add(post);
}
