import 'package:egyptianrc/bloc/status.dart';
import 'package:egyptianrc/presentation/shared/widget/error_widget.dart';
import 'package:egyptianrc/presentation/view/user_view/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bloc/location_bloc/location_bloc.dart';
import '../../../shared/widget/loading_text.dart';

class MapDisplayer extends StatefulWidget {
  const MapDisplayer({
    Key? key,
  }) : super(key: key);

  @override
  State<MapDisplayer> createState() => _MapState();
}

class _MapState extends State<MapDisplayer> {
  void _onMapCreated(GoogleMapController controller) =>
      context.read<LocationBloc>().add(LocationRequested(controller));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      return state.status == BlocStatus.error
          ? const ErrorView()
          : Stack(
              children: [
                GoogleMap(
                  markers: Set.from(state.markers),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: state.location, zoom: 7.0),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: SearchBar(),
                ),
                Visibility(
                  visible: state.status == BlocStatus.gettingData,
                  child: Expanded(
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: const Center(child: LoadingText()),
                    ),
                  ),
                ),
                // const SizedBox(width: double.infinity),
              ],
            );
    });
  }
}
