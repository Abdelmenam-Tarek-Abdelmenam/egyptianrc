import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/bloc/status.dart';
import 'package:egyptianrc/data/data_sources/location_service.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/failure/post_disaster_failure.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService = LocationService();

  LocationBloc() : super(LocationState.initial()) {
    on<LocationRequested>(_locationRequested);
  }

  Future<void> _locationRequested(
      LocationRequested event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
        status: BlocStatus.gettingData, controller: event.controller));
    Either<Position, PostDisasterFailure> value =
        await _locationService.getCurrentPosition();
    await value.fold((left) async {
      await event.controller
          .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(left.latitude, left.longitude),
        zoom: 18,
      )));

      List<Marker> markers = <Marker>[
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          markerId: MarkerId('${left.latitude}${left.longitude}'),
          position: LatLng(left.latitude, left.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      ];

      emit(state.copyWith(
          controller: event.controller,
          status: BlocStatus.getData,
          markers: markers,
          zoom: state.zoom,
          location: LatLng(left.latitude, left.longitude)));
    }, (right) {
      right.show;
      emit(state.copyWith(status: BlocStatus.error));
    });
  }
}
