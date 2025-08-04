import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/DataModels/bus_stop.dart';
import '../widgets/bus_stop_list_tile.dart';
import '../widgets/popup_menu.dart';

class BusStopInfo extends StatefulWidget {
  final BusStop busStop;

  const BusStopInfo({super.key, required this.busStop});

  @override
  BusStopInfoState createState() => BusStopInfoState();
}

class BusStopInfoState extends State<BusStopInfo> {
  late ErrorSnackBar errorPrompt;

  BusStopInfoState();


  @override
  initState() {
    super.initState();

    errorPrompt = ErrorSnackBar(context: context);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => loadFavoritesList()); //run a start item on startup
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
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(widget.busStop.latitude, widget.busStop.longitude), // Center the map over London
          initialZoom: 15,
        ),
        children: [
          TileLayer( // Bring your own tiles
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
            userAgentPackageName: 'com.example.app', // Add your app identifier
            // And many more recommended properties!
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 50,
                height: 50,
                point: LatLng(widget.busStop.latitude, widget.busStop.longitude),
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
          RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
              ),
              // Also add images...
            ],
          ),
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.always,
          alignDirectionOnUpdate: AlignOnUpdate.never,
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
        )
        ],
      )
    );
  }
}
