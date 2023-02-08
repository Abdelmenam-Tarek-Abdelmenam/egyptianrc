import 'dart:html';
import 'dart:ui' as ui;
import 'package:egyptianrc/data/models/disaster_post.dart';
import 'package:flutter/material.dart';
import 'package:egyptianrc/data/models/location.dart' as disaster;
import 'package:google_maps/google_maps.dart' as gMap;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart'
    as moveMap;

class WebMap extends StatefulWidget {
  final List<DisasterPost> positions;

  const WebMap({super.key, required this.positions});

  @override
  State<WebMap> createState() => _WebMapState();
}

class _WebMapState extends State<WebMap> {
  @override
  Widget build(BuildContext context) {
    return _map(widget.positions);
  }

  Widget _map(List<DisasterPost> positions) {
    const String htmlId = "map";
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      gMap.MapOptions mapOptions = gMap.MapOptions()
        ..zoom = 6.5
        ..mapId = htmlId
        ..zoomControl = false
        ..mapTypeId = gMap.MapTypeId.ROADMAP
        ..center = gMap.LatLng(26.8357675, 30.7956597);
      final elem = DivElement()..id = htmlId;
      gMap.GMap map = gMap.GMap(elem, mapOptions);
      // gMap.CircleOptions circleOptions = gMap.CircleOptions()
      //   ..center = gMap.LatLng(26, 30)
      //   ..radius = 150
      //   ..strokeColor = '#FF0000'
      //   ..strokeOpacity = 0.8
      //   ..strokeWeight = 2
      //   ..fillColor = '#FF0000'
        ..fillOpacity = 0.35;
      for (var element in positions) {
        gMap.Marker(gMap.MarkerOptions()
              ..position = gMap.LatLng(
                  element.position.latitude, element.position.longitude)
              ..map = map
              ..clickable = true
              ..animation = gMap.Animation.DROP
              ..title = htmlId)
            .onClick
            .listen((event) {
          map.panTo(gMap.LatLng(
              element.position.latitude, element.position.longitude));
          map.zoom = 16;

          // print('click on marker ${map.data?.get('getProperty')}');
          // final areaCircle = gMap.CircleOptions()
          //   ..map = map
          //   ..center = gMap.LatLng(
          //       element.position.latitude, element.position.longitude)
          //   ..radius = 400;
          // gMap.Circle(areaCircle..map = null);
        });
      }

      map.onCenterChanged.listen((event) {});
      map.onDragstart.listen((event) {
        print('onDragend');
        print(map.center?.lat);
        print(map.center!.lng);
        print(map.zoom);
      });
      map.onDragend.listen((event) {
        print('onDragend');
        print(map.center?.lat);
        print(map.center!.lng);
        print(map.zoom);
      });

      return elem;
    });
    return const HtmlElementView(viewType: htmlId);
  }
}
