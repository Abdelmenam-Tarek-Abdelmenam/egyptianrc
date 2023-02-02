import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/data/failure/post_disaster_failure.dart';
import 'package:egyptianrc/data/models/disaster_post.dart';
import 'package:egyptianrc/data/models/disaster_type.dart';
import 'package:egyptianrc/data/models/location.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

part 'post_disaster_event.dart';
part 'post_disaster_state.dart';

class PostDisasterBloc extends Bloc<PostDisasterEvent, PostDisasterState> {
  PostDisasterBloc() : super(PostDisasterState.initial()) {
    on<PostDisasterEvent>(_postLocationEvent);
  }

  FutureOr<void> _postLocationEvent(
      PostDisasterEvent event, Emitter<PostDisasterState> emit) {}
}
