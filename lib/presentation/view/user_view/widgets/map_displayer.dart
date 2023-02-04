import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> _goToLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: widget.currentPosition,
          zoom: 19.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 6,
            ),
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              state.currentPosition.map((right) => _goToLocation());
            },
          );
        },
      ),
    );
  }
}
