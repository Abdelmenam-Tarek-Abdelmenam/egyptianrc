import 'dart:async';

import 'package:egyptianrc/data/failure/post_disaster_failure.dart';
import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Either<Position, PostDisasterFailure>> getCurrentPosition() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.requestPermission();

    if (!serviceEnabled) {
      return Right(PostDisasterFailure.getFailure('location_service_disabled'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Right(PostDisasterFailure.getFailure('permission_denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Right(PostDisasterFailure.getFailure('permission_denied'));
    }
    return Left(await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high));
  }
}
