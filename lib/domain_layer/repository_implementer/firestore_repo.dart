import 'package:egyptianrc/data/data_sources/web_services/firestore_repository.dart';
import 'package:either_dart/either.dart';

import '../../data/error_state.dart';

class DataBaseRepository {
  final FireStoreRepository _repository = FireStoreRepository();

  Future<Either<Failure, Object>> test() async {
    try {
      return Right(_repository.toString());
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("Error happened while getting user data"));
    }
  }
}
