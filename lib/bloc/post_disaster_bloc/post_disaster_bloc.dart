import 'dart:async';

import 'package:bloc/bloc.dart';
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
  }

  FutureOr<void> _postDisasterEvent(
      PostDisasterToCloudEvent event, Emitter<PostDisasterState> emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));

    if (event.disasterPost.photoUrl == null) {
      print('BLOC change error to provide_photo');
      emit(
        state.copyWith(
          status: BlocStatus.error,
          successOrFailureOption: const Left(
            PostDisasterFailure('provide_photo'),
          ),
        ),
      );
      return;
    } else {
      await _fireStoreRepository
          .uploadPost(event.disasterPost.toMap())
          .then((value) {
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
  }

  FutureOr<void> _postPhotoDisasterEvent(
      PostPhotoDisasterEvent event, Emitter<PostDisasterState> emit) async {
    emit(state.copyWith(status: BlocStatus.postingPhoto));
    await _fireStorageRepository
        .upload(event.mediaFile)
        .then((value) => {
              emit(
                state.copyWith(
                    status: BlocStatus.postedPhoto,
                    successOrFailureOption: const Right(null),
                    photoUrl: value),
              ),
            })
        .catchError((error) => {
              emit(
                state.copyWith(
                  status: BlocStatus.error,
                  successOrFailureOption: Left(
                    PostDisasterFailure(error.toString()),
                  ),
                ),
              )
            });
  }
}
