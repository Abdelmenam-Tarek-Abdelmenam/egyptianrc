part of 'location_bloc.dart';

class LocationState extends Equatable {
  final Either<PostDisasterFailure, Location> currentPosition;
  final bool isLoading;

  const LocationState({
    required this.currentPosition,
    required this.isLoading,
  });
  factory LocationState.initial() {
    return LocationState(
      currentPosition: Right(Location.intialLocation),
      isLoading: false,
    );
  }
  @override
  List<Object> get props => [currentPosition, isLoading];

  LocationState copyWith({
    Either<PostDisasterFailure, Location>? currentPosition,
    bool? isLocationServiceEnabled,
    bool? isPermissionGranted,
    bool? isLoading,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
