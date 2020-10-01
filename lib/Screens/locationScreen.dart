import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';



class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  Widget build(BuildContext context) {
    var overlayImages = <OverlayImage>[
      OverlayImage(
          bounds: LatLngBounds(LatLng(41.3426441, 69.3377809), LatLng(41.342, 69.3367)),
          opacity: 0.8,
          imageProvider: NetworkImage(
              'https://www.uzdaily.uz/storage/img/Askar-foto/262A6847.jpg')),
    ];

    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(41.3426441, 69.3377809),
        builder: (ctx) => Container(
          child: Icon(Icons.location_on,
            color: Colors.red,
            size: 75,
            key: ObjectKey(Colors.blue),)
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.yellow,
        title: Text("Locate Us"),
        centerTitle: true,
        actions: [
          Icon(Icons.lightbulb_outline),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.share),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(41.3426441, 69.3377809),
                zoom: 18.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  // For example purposes. It is recommended to use
                  // TileProvider with a caching and retry strategy, like
                  // NetworkTileProvider or CachedNetworkTileProvider
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
                OverlayImageLayerOptions(overlayImages: overlayImages),
                MarkerLayerOptions(markers: markers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
