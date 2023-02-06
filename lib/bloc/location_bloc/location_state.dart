part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng location;
  final BlocStatus status;
  final List<Marker> markers;
  final GoogleMapController? controller;
  double zoom;
  LocationState({
    required this.location,
    required this.status,
    required this.markers,
    this.controller,
    this.zoom = 15,
  });

  factory LocationState.initial() {
    return LocationState(
      markers: [],
      controller: null,
      location: const LatLng(26.8206, 30.8025),
      status: BlocStatus.idle,
      zoom: 7,
    );
  }
  @override
  List<Object> get props => [status, markers.length, location, zoom];

  LocationState copyWith({
    LatLng? location,
    BlocStatus? status,
    List<Marker>? markers,
    GoogleMapController? controller,
    double? zoom,
  }) {
    return LocationState(
      location: location ?? this.location,
      status: status ?? this.status,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
      zoom: zoom ?? this.zoom,
    );
  }
}
