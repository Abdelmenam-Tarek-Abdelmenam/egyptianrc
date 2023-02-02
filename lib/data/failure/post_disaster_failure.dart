import 'package:flutter/material.dart';

Map<String, PostDisasterFailure> _postDisasterFailureLookUp = const {
  
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
