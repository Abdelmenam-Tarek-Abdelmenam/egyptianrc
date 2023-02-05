import 'dart:async';

import 'package:egyptianrc/data/data_sources/location_service.dart';
import 'package:egyptianrc/data/failure/post_disaster_failure.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bloc/bloc/location_bloc.dart';

class MapDisplayer extends StatefulWidget {
  final LatLng currentPosition;

  const MapDisplayer({
    Key? key,
    required this.currentPosition,
  }) : super(key: key);

  @override
  State<MapDisplayer> createState() => _MapState();
}

class _MapState extends State<MapDisplayer> {
  final LatLng _center = const LatLng(26.8206, 30.8025);
  final Completer<GoogleMapController> _controller = Completer();
  Future<void> _goToLocation(LatLng toLocation) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: toLocation,
          zoom: 19.0,
        ),
      ),
    );
  }
  // Future<void> _goToLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: widget.currentPosition,
  //         zoom: 19.0,
  //       ),
  //     ),
  //   );
  // }

  // late GoogleMapController mapController;

  // LatLng? _currentPosition;
  // bool _isLoading = true;
  // @override
  // void initState() {
  //   getLocation();
  //   super.initState();
  //   // BlocProvider.of<LocationBloc>(context).add(const LocationRequested());
  //   // bloc = BlocProvider.of<LocationBloc>(context);
  // }

  // getLocation() async {
  //   print('before set state futureLocation: ');

  //   Either<Position, PostDisasterFailure> futureLocation =
  //       await LocationService().getCurrentPosition();
  //   print(
  //       'after set state futureLocation: ${futureLocation.fold((left) => left.altitude + left.latitude, (right) => null)}');
  //   setState(() {
  //     _isLoading = false;
  //     _currentPosition = LatLng(
  //         futureLocation.fold((left) => left.altitude, (right) => 0),
  //         futureLocation.fold((left) => left.longitude, (right) => 0));
  //   });
  // }

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            print('state.currentPosition: ${state.currentPosition}');
            _goToLocation(state.currentPosition.fold(
                (left) => const LatLng(0, 0),
                (right) => LatLng(right.latitude, right.longitude)));
          });
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
      );
    });
  }
}
