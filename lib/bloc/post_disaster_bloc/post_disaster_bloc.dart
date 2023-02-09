import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/bloc/status.dart';
import 'package:egyptianrc/data/data_sources/web_services/firestorage_repository.dart';
import 'package:egyptianrc/data/data_sources/web_services/firestore_repository.dart';
import 'package:egyptianrc/data/failure/post_disaster_failure.dart';
import 'package:egyptianrc/data/models/disaster_post.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

part 'post_disaster_event.dart';
part 'post_disaster_state.dart';

class PostDisasterBloc extends Bloc<PostDisasterEvent, PostDisasterState> {
  final FireStoreRepository _fireStoreRepository = FireStoreRepository();
  final FireStorageRepository _fireStorageRepository = FireStorageRepository();

  PostDisasterBloc() : super(PostDisasterState.initial()) {
    on<PostDisasterToCloudEvent>(_postDisasterEvent);
    on<PostPhotoDisasterEvent>(_postPhotoDisasterEvent);
    on<PostAudioDisasterEvent>(_postAudioDisasterEvent);
  }

  FutureOr<void> _postDisasterEvent(
      PostDisasterToCloudEvent event, Emitter<PostDisasterState> emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));
    Map<String, dynamic> data = {
      ...event.disasterPost.toMap(),
      "userData": AuthBloc.user.toJson
    };
    await _fireStoreRepository.uploadPost(data).then((value) {
      emit(
        state.copyWith(
          status: BlocStatus.getData,
          successOrFailureOption: Right(value),
        ),
      );

      return value;
    }).catchError((error) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          successOrFailureOption: Left(
            PostDisasterFailure(error.toString()),
          ),
        ),
      );
      print(error.toString());
      return error;
    });
  }

  //! I have bug here
  FutureOr<void> _postPhotoDisasterEvent(
      PostPhotoDisasterEvent event, Emitter<PostDisasterState> emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));

    try {
      String result = await _fireStorageRepository.upload(event.mediaFile);
      print('BLOC change result: url $result');
      emit(state.copyWith(
          status: BlocStatus.postedPhoto,
          successOrFailureOption: const Right(null),
          photoUrl: result));
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.postedPhoto,
        successOrFailureOption: Left(PostDisasterFailure(e.toString())),
      ));
    }
  }

  FutureOr<void> _postAudioDisasterEvent(
      PostAudioDisasterEvent event, Emitter<PostDisasterState> emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));

    await _fireStorageRepository.upload(event.mediaFile).then((value) {
      emit(
        state.copyWith(
            status: BlocStatus.postedAudio,
            successOrFailureOption: const Right(null),
            audioUrl: value),
      );
    }).catchError((error) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          successOrFailureOption: Left(
            PostDisasterFailure(error.toString()),
          ),
        ),
      );
    });
  }
}
