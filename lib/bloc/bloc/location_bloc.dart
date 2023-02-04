import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/data/data_sources/location_service.dart';
import 'package:egyptianrc/data/models/location.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/failure/post_disaster_failure.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService = LocationService();

  LocationBloc() : super(LocationState.initial()) {
    on<LocationRequested>(_locationRequested);
    on<LocationUpdated>(_locationUpdated);
  }

  Future<void> _locationRequested(
      LocationEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _locationService.getCurrentPosition().then(
          (value) => value.fold((left) {
            emit(state.copyWith(
                isLoading: false,
                currentPosition: Right(Location(
                    latitude: left.latitude, longitude: left.longitude))));
          }, (right) {
            emit(state.copyWith(currentPosition: Left(right)));
          }),
        );
  }

  Future<void> _locationUpdated(
      LocationUpdated event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _locationService
        .goToLocation(event.cameraPosition, event.controllerCompleter)
        .then(
          (value) => emit(
            state.copyWith(
              isLoading: false,
              currentPosition: Right(
                Location(
                    latitude: event.cameraPosition.target.latitude,
                    longitude: event.cameraPosition.target.longitude),
              ),
            ),
          ),
        );
  }
}
