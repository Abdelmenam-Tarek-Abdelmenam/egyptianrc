import 'dart:async';

import 'package:egyptianrc/data/failure/post_disaster_failure.dart';
import 'package:egyptianrc/data/models/location.dart';
import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  Future<Either<Position, PostDisasterFailure>> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
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

  Future<void> goToLocation(CameraPosition cameraPosition,
      Completer<GoogleMapController> controllerCompleter) async {
    final GoogleMapController controller = await controllerCompleter.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}
