import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:humantiy/constants.dart';
import 'package:humantiy/core/locator.dart';
import 'package:humantiy/core/services/data_services.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<LatLng> tappedPoints = [];

  void test() async {
    for (final cityName in citys) {
      var model = getIt<DataServices>(param1: cityName, param2: '');
      final tester = await model.getCityData();
      print('Şehir: $cityName pm25: ${tester.pm25} Pm10: ${tester.pm10} Co: ${tester.co}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var markers = tappedPoints.map((latlng) {
    //   return Marker(
    //     width: 80.0,
    //     height: 80.0,
    //     point: latlng,
    //     builder: (ctx) => Container(
    //       child: Icon(
    //         Icons.location_on,
    //         color: Colors.red,
    //         size: 50,
    //       ),
    //     ),
    //   );
    // }).toList();
    return Scaffold(
      body: Center(
        child: Container(
          child: FlutterMap(
            options: MapOptions(
              onTap: _handleTap,
              plugins: [
                MarkerClusterPlugin(),
              ],
              zoom: 5.0,
              minZoom: 2.0,
              maxZoom: 20.0,
              center: LatLng(41, 28),
            ),
            layers: [
              TileLayerOptions(
                maxZoom: 20,
                urlTemplate: 'http://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                subdomains: ['0', '1', '2', '3'],
                tileProvider: NonCachingNetworkTileProvider(),
              ),
              // MarkerLayerOptions(markers: markers)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
      ),
    );
  }

  void _handleTap(LatLng latlng) {
    print(latlng.latitude);
    print(latlng.longitude);
    // setState(() {
    //   tappedPoints.add(latlng);
    // });
  }
}
