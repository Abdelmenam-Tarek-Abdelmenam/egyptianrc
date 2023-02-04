// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:egyptianrc/presentation/shared/widget/buttons.dart';
import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:egyptianrc/presentation/shared/widget/error_image.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:egyptianrc/presentation/view/post_view/widgets/record_sound_widget.dart';
import 'package:egyptianrc/presentation/view/post_view/widgets/record_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  ValueNotifier<String?> audioFileController = ValueNotifier(null);
  ValueNotifier<String?> imageFileController = ValueNotifier(null);

  MapController? controller;

  @override
  void initState() {
    imageFileController.addListener(() {
      print(imageFileController.value);
    });
    _determinePosition().then((value) {
      setState(() {
        controller = MapController(
          location: LatLng(value.latitude, value.longitude),
          zoom: 14,
        );
      });
    }).catchError((error, _) {
      showToast(error);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RecordSoundWidget(audioFileController),
          Dividers.h10,
          RecordImageIcon(imageFileController),
        ],
      ),
      bottomNavigationBar: confirmWidget(),
      body: controller == null
          ? const Center(child: LoadingText())
          : MapLayout(
              controller: controller!,
              builder: (context, transformer) {
                return TileLayer(
                  builder: (context, x, y, z) {
                    final tilesInZoom = pow(2.0, z).floor();

                    while (x < 0) {
                      x += tilesInZoom;
                    }
                    while (y < 0) {
                      y += tilesInZoom;
                    }

                    x %= tilesInZoom;
                    y %= tilesInZoom;

                    //Google Maps
                    final url =
                        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                    return ErrorImage(
                      url,
                    );
                  },
                );
              },
            ),
    );
  }

  Widget confirmWidget() => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 20),
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
}
