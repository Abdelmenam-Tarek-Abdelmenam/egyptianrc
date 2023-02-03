import 'package:flutter/material.dart';

Map<String, PostDisasterFailure> _postDisasterFailureLookUp = const {
  'location_service_disabled': LocationServiceDisabledFailure(),
  'unkown_error_in_location_service': UnknownErrorInLocationService(),
  'permission_denied': PermissionDeniedFailure(),
};

@immutable
class PostDisasterFailure implements Exception {
  final String errorMessage;
  const PostDisasterFailure._({required this.errorMessage});

  factory PostDisasterFailure.getFailure(String errorCode) {
    if (_postDisasterFailureLookUp.containsKey(errorCode)) {
      return _postDisasterFailureLookUp[errorCode]!;
    } else {
      return const ServerError();
    }
  }
}

class ServerError extends PostDisasterFailure {
  const ServerError() : super._(errorMessage: 'Server Error');
}

class LocationServiceDisabledFailure extends PostDisasterFailure {
  const LocationServiceDisabledFailure()
      : super._(errorMessage: 'Location Service is Disabled');
}

class PermissionDeniedFailure extends PostDisasterFailure {
  const PermissionDeniedFailure() : super._(errorMessage: 'Permission Denied');
}

class UnknownErrorInLocationService extends PostDisasterFailure {
  const UnknownErrorInLocationService()
      : super._(errorMessage: 'Unknown Error in Location Service');
}
