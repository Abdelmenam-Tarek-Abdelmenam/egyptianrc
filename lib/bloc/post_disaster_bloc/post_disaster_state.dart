part of 'post_disaster_bloc.dart';

class PostDisasterState extends Equatable {
  final Either<PostDisasterFailure, void> successOrFailureOption;
  final BlocStatus status;
  final String photoUrl;
  final String? audioUrl;
  const PostDisasterState({
    required this.successOrFailureOption,
    required this.photoUrl,
    this.audioUrl,
    this.status = BlocStatus.idle,
  });

  @override
  List<Object?> get props => [
        successOrFailureOption,
        status,
        photoUrl,
        audioUrl,
      ];
  factory PostDisasterState.initial() => const PostDisasterState(
        successOrFailureOption: Right(null),
        photoUrl: '',
        audioUrl: '',
      );

  @override
  String toString() {
    return 'PostDisasterState(successOrFailureOption: $successOrFailureOption, status: $status)';
  }

  PostDisasterState copyWith({
    Either<PostDisasterFailure, void>? successOrFailureOption,
    BlocStatus? status,
    String? photoUrl,
    String? audioUrl,
  }) {
    return PostDisasterState(
      successOrFailureOption:
          successOrFailureOption ?? this.successOrFailureOption,
      status: status ?? this.status,
      photoUrl: photoUrl ?? this.photoUrl,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }
}
