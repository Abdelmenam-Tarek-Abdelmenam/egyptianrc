import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerManager {
  static Marker location = Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    infoWindow: const InfoWindow(title: 'Your Location'),
    markerId: const MarkerId('location'),
  );

  
}
