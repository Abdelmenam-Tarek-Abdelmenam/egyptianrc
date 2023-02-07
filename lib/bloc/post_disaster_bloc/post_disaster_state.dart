part of 'post_disaster_bloc.dart';

class PostDisasterState extends Equatable {
  final Either<PostDisasterFailure, void> successOrFailureOption;
  final bool isSubmitting;
  final BlocStatus status;
  const PostDisasterState({
    required this.successOrFailureOption,
    required this.isSubmitting,
    this.status = BlocStatus.idle,
  });

  @override
  List<Object?> get props => [
        successOrFailureOption,
        isSubmitting,
      ];
  factory PostDisasterState.initial() => const PostDisasterState(
        successOrFailureOption: Right(null),
        isSubmitting: false,
      );

  PostDisasterState copyWith({
    Either<PostDisasterFailure, void>? successOrFailureOption,
    bool? isSubmitting,
    BlocStatus? status,
  }) {
    return PostDisasterState(
      successOrFailureOption:
          successOrFailureOption ?? this.successOrFailureOption,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'PostDisasterState(successOrFailureOption: $successOrFailureOption, isSubmitting: $isSubmitting, status: $status)';
  }
}
