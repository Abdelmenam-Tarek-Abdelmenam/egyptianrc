import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:egyptianrc/presentation/view/user_view/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../shared/widget/buttons.dart';
import '../../../shared/widget/dividers.dart';
import '../widgets/record_image_widget.dart';
import '../widgets/record_sound_widget.dart';
//? should I use this or not? YEs yyou can use it

class PostDisasterView extends StatefulWidget {
  const PostDisasterView({super.key});

  @override
  State<PostDisasterView> createState() => _PostDisasterViewState();
}

class _PostDisasterViewState extends State<PostDisasterView> {
  late GoogleMapController mapController;
  final ValueNotifier<String?> audioFileController = ValueNotifier(null);
  final ValueNotifier<String?> imageFileController = ValueNotifier(null);

  LatLng? _center;
  List<Marker> markers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    moveCameraToMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RecordSoundWidget(audioFileController),
            Dividers.h10,
            RecordImageIcon(imageFileController),
          ],
        ),
        bottomNavigationBar: confirmWidget(),
        body: Stack(
          children: [
            GoogleMap(
              markers: Set.from(
                markers,
              ),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center ?? const LatLng(45.521563, -122.677433),
                zoom: 11.0,
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: SearchBar(),
            ),
            Visibility(
              visible: _center == null,
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
        ));
  }

  Widget confirmWidget() => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30)
              .copyWith(bottom: 20, right: 70),
          child: DefaultFilledButton(
            label: StringManger.post,
            onPressed: () {},
          ),
        ),
      );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> moveCameraToMe() async {
    _determinePosition().then((value) async {
      double myLat = value.latitude;
      double myLan = value.longitude;

      mapController
          .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(myLat, myLan),
        zoom: 15,
      )))
          .then((value) {
        setState(() {
          _center = LatLng(myLan, myLan);
        });
      });
    }).catchError((err) {
      showToast(err.toString());
    });
  }
}
