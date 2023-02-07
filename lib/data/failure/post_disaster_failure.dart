import 'package:egyptianrc/data/error_state.dart';
import 'package:flutter/material.dart';

Map<String, PostDisasterFailure> _postDisasterFailureLookUp = const {
  'location_service_disabled': LocationServiceDisabledFailure(),
  'unkown_error_in_location_service': UnknownErrorInLocationService(),
  'permission_denied': PermissionDeniedFailure(),
  'provide_photo': ProvidePhotoFailure(),
};

@immutable
class PostDisasterFailure extends Failure {
  const PostDisasterFailure(super.message);

  factory PostDisasterFailure.getFailure(String errorCode) {
    if (_postDisasterFailureLookUp.containsKey(errorCode)) {
      return _postDisasterFailureLookUp[errorCode]!;
    } else {
      return const ServerError();
    }
  }
}

class ServerError extends PostDisasterFailure {
  const ServerError() : super('Server Error');
}

class LocationServiceDisabledFailure extends PostDisasterFailure {
  const LocationServiceDisabledFailure()
      : super('Location Service is Disabled');
}

class PermissionDeniedFailure extends PostDisasterFailure {
  const PermissionDeniedFailure() : super('Permission Denied');
}

class UnknownErrorInLocationService extends PostDisasterFailure {
  const UnknownErrorInLocationService()
      : super('Unknown Error in Location Service');
}

class ProvidePhotoFailure extends PostDisasterFailure {
  const ProvidePhotoFailure() : super('Provide Photo');
}
