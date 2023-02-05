part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng location;
  final BlocStatus status;
  final List<Marker> markers;
  final GoogleMapController? controller;
  const LocationState(
      {required this.markers,
      required this.location,
      required this.status,
      required this.controller});

  factory LocationState.initial() {
    return const LocationState(
      markers: [],
      controller: null,
      location: LatLng(26.8206, 30.8025),
      status: BlocStatus.idle,
    );
  }
  @override
  List<Object> get props => [status, markers.length, location];

  LocationState copyWith(
      {List<Marker>? markers,
      BlocStatus? status,
      GoogleMapController? controller,
      LatLng? location}) {
    return LocationState(
      controller: controller ?? this.controller,
      markers: markers ?? this.markers,
      status: status ?? this.status,
      location: location ?? this.location,
    );
  }
}
