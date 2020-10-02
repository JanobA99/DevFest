import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gtg_tashkent/home.dart';
import 'package:latlong/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';



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
          imageProvider: AssetImage(
              'assets/itPark.jpeg')),
    ];

    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(41.3426441, 69.3377809),
        builder: (ctx) => GestureDetector(
          onTap: ()=>MapsLauncher.launchCoordinates(
              41.3426441, 69.3377809, 'IT Park are here'),
          child: Container(
            child: Icon(Icons.location_on,
              color: Colors.red,
              size: 50,
              key: ObjectKey(Colors.blue),)
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: dark ? Colors.white : Colors.black,),
        ),
        toolbarHeight: 35,
        backgroundColor: dark ? Colors.black : Colors.yellow,
        title: Text("Locate Us",  style: TextStyle(color: dark ? Colors.white : Colors.black,),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(dark
                ? Icons.lightbulb_outline
                : Icons.lightbulb_outline,
              color:  dark ? Colors.white : Colors.black,),
            onPressed: (){
              if(dark){
                setState(() {
                  dark=false;
                });
              }
              else{
                setState(() {
                  dark=true;
                });
              }
            },),
          IconButton(onPressed:(){},icon: Icon(Icons.share, color:  dark ? Colors.white : Colors.black,)),

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
