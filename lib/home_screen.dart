import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Placemark>? placemark;
  String? longitude;
  String? latitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Geolocator.checkPermission();
              await Geolocator.requestPermission();
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              // longitude = position.longitude.toString();
              // latitude = position.latitude.toString();
              // print("The latitude is ${position.latitude}");
              // print("The longitude is ${position.longitude}");
              List<Placemark> place = await GeocodingPlatform.instance
                  .placemarkFromCoordinates(
                      position.latitude, position.longitude);

              setState(() {
                placemark = place;
              });
            },
            child: const Text("Press"),
          ),
          placemark != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Text(placemark![0].country.toString()),
                      Text(placemark![0].postalCode.toString()),
                      Text(placemark![0].administrativeArea.toString()),
                      Text(placemark![0].subAdministrativeArea.toString()),
                      Text(placemark![0].locality.toString()),
                      Text(placemark![0].thoroughfare.toString()),
                    ])
              : Container()
        ],
      ),
    );
  }
}
