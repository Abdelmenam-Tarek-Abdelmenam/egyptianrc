part of 'post_disaster_bloc.dart';

class PostDisasterState extends Equatable {
  final Location location;
  final Either<PostDisasterFailure, void> successOrFailureOption;
  final bool isSubmitting;
  final DisasterMedia? mediaEvidence;
  final String? description;
  final String? type;
  final DisasterType? disasterType;

  const PostDisasterState({
    required this.location,
    required this.successOrFailureOption,
    required this.isSubmitting,
    this.mediaEvidence,
    this.description,
    this.type,
    this.disasterType,
  });

  @override
  List<Object?> get props => [
        location,
        successOrFailureOption,
        isSubmitting,
        mediaEvidence,
        description,
        type,
        disasterType
      ];
  factory PostDisasterState.initial() => PostDisasterState(
        location: Location(latitude: 0.0, longitude: 0.0),
        successOrFailureOption: const Right(null),
        isSubmitting: false,
        description: '',
        type: '',
      );
}
