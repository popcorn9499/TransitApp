import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../api/DataModels/bus_stop.dart';
import '../widgets/layout_stop_times_header.dart';
import '../widgets/popup_menu.dart';

class BusStopInfo extends StatefulWidget {
  final BusStop busStop;

  const BusStopInfo({super.key, required this.busStop});

  @override
  BusStopInfoState createState() => BusStopInfoState();
}

class BusStopInfoState extends State<BusStopInfo> {
  late ErrorSnackBar errorPrompt;
  final MapController _mapController = MapController();
  late AlignOnUpdate _alignPositionOnUpdate;
  late final StreamController<double?> _alignPositionStreamController;
  BusStopInfoState();

  @override
  initState() {
    super.initState();
    _alignPositionOnUpdate = AlignOnUpdate.always;
    _alignPositionStreamController = StreamController<double?>();
    errorPrompt = ErrorSnackBar(context: context);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => fixMapBounds()); //run a start item on startup
  }

  Future<void> fixMapBounds() async {
    Position currentLocation = await Geolocator.getCurrentPosition();
    LatLng currentLocationLatLng =
        LatLng(currentLocation.latitude, currentLocation.longitude);

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds.fromPoints([
          LatLng(widget.busStop.latitude, widget.busStop.longitude),
          currentLocationLatLng, // You'll need to get this from your location stream
        ]),
        padding: EdgeInsets.all(50), // Optional: Adds padding around the bounds
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String stopNumber = widget.busStop.number.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text("Stop #$stopNumber Information"),
          actions: [
            PopupMenu(),
          ],
        ),
        body: Column(children: [
          LayoutStopTimesHeader(
            routeName: widget.busStop.name,
          ),
          Expanded(
              child: Stack(children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(widget.busStop.latitude,
                    widget.busStop.longitude), // Center the map over London
                initialZoom: 15,
                onPositionChanged: (MapCamera camera, bool hasGesture) {
                  if (hasGesture &&
                      _alignPositionOnUpdate != AlignOnUpdate.never) {
                    setState(
                      () => _alignPositionOnUpdate = AlignOnUpdate.never,
                    );
                  }
                },
              ),
              children: [
                TileLayer(
                  // Bring your own tiles
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                  userAgentPackageName:
                      'com.example.app', // Add your app identifier
                  // And many more recommended properties!
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50,
                      height: 50,
                      point: LatLng(
                          widget.busStop.latitude, widget.busStop.longitude),
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),

                CurrentLocationLayer(
                  alignPositionOnUpdate: _alignPositionOnUpdate,
                  alignDirectionOnUpdate: AlignOnUpdate.never,
                  alignPositionStream: _alignPositionStreamController.stream,
                  style: LocationMarkerStyle(
                    marker: const DefaultLocationMarker(
                      child: Icon(
                        Icons.navigation,
                        color: Colors.white,
                      ),
                    ),
                    markerSize: const Size(40, 40),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        // Align the location marker to the center of the map widget
                        // on location update until user interact with the map.
                        setState(
                          () => _alignPositionOnUpdate = AlignOnUpdate.always,
                        );
                        // Align the location marker to the center of the map widget
                        // and zoom the map to level 18.
                        _alignPositionStreamController.add(18);
                      },
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // TODO add attribution to the map
                // RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
                //   attributions: [
                //     TextSourceAttribution(
                //       'OpenStreetMap contributors',
                //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
                //     ),
                //     // Also add images...
                //   ],
                // ),
              ],
            )
          ]))
        ]));
  }
}
