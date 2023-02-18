// ignore_for_file: avoid_web_libraries_in_flutter
// ignore_for_file: depend_on_referenced_packages

import 'dart:ui' as ui;
import 'package:egyptianrc/data/models/disaster_post.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:google_maps/google_maps.dart' as g_map;
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart'
    as g_map_web;

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
    // return Container();
    String htmlId = "map${positions.length}";

    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      g_map.MapOptions mapOptions = g_map.MapOptions()
        ..zoom = 6.5
        ..mapId = htmlId
        ..zoomControl = false
        ..mapTypeId = g_map.MapTypeId.ROADMAP
        ..center = g_map.LatLng(26.8357675, 30.7956597);
      final elem = DivElement()..id = htmlId;
      g_map.GMap map = g_map.GMap(elem, mapOptions);
      g_map_web.CircleController circleController = g_map_web.CircleController(
          circle: g_map.Circle(g_map.CircleOptions()
            ..map = map
            ..center = g_map.LatLng(26.8357675, 30.7956597)
            ..radius = 900
            ..strokeColor = '#FF0000'
            ..strokeOpacity = 0.8
            ..strokeWeight = 2
            ..fillColor = '#FF0000'
            ..fillOpacity = 0.35));

      for (int i = 0; i < positions.length; i++) {
        final element = positions[i];

        g_map.Marker(g_map.MarkerOptions()
              ..position = g_map.LatLng(
                  element.position.latitude, element.position.longitude)
              ..map = map
              ..clickable = true
              ..animation = g_map.Animation.DROP
              ..title = element.disasterType)
            .onClick
            .listen((event) {
          map.panTo(g_map.LatLng(
              element.position.latitude, element.position.longitude));
          map.zoom = 16;
          circleController.update(g_map.CircleOptions()
            ..map = map
            ..center = g_map.LatLng(
                element.position.latitude, element.position.longitude)
            ..radius = 150
            ..strokeColor = '#FF0000'
            ..strokeOpacity = 0.8
            ..strokeWeight = 2
            ..fillColor = '#FF0000'
            ..fillOpacity = 0.35);
          // print('click on marker ${map.data?.get('getProperty')}');
          // final areaCircle = gMap.CircleOptions()
          //   ..map = map
          //   ..center = gMap.LatLng(
          //       element.position.latitude, element.position.longitude)
          //   ..radius = 400;
          // gMap.Circle(areaCircle..map = null);
        });
      }

      // map.onCenterChanged.listen((event) {});
      // map.onDragstart.listen((event) {
      //   print('onDragend');
      //   print(map.center?.lat);
      //   print(map.center!.lng);
      //   print(map.zoom);
      // });
      // map.onDragend.listen((event) {
      //   print('onDragend');
      //   print(map.center?.lat);
      //   print(map.center!.lng);
      //   print(map.zoom);
      // });

      return elem;
    });
    return HtmlElementView(viewType: htmlId);
  }
}
