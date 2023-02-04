part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationRequested extends LocationEvent {
  const LocationRequested();
}

class LocationUpdated extends LocationEvent {
  final CameraPosition cameraPosition;
  final Completer<GoogleMapController> controllerCompleter;
  const LocationUpdated(
      {required this.cameraPosition, required this.controllerCompleter});

  @override
  List<Object> get props => [cameraPosition, controllerCompleter];
}
