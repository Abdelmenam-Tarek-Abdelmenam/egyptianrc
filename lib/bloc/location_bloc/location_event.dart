part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationRequested extends LocationEvent {
  final GoogleMapController controller;

  const LocationRequested(this.controller);

  @override
  List<Object> get props => [controller];
}
