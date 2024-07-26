
import 'package:cityguide/repositories/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';


class locationScreen extends StatefulWidget {
  final double lat;
  final double lng;
  const locationScreen({super.key, required this.lat, required this.lng});

  @override
  State<locationScreen> createState() => _locationScreenState();
}

class _locationScreenState extends State<locationScreen> {
  late String currentAddress;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

  }
  void _getCurrentLocation() async {
    try {
      // Get the current address from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.lat,
        widget.lng,
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          currentAddress = placemarks[0].street ?? 'Address not found';
        });
      } else {
        setState(() {
          currentAddress = 'Address not found';
        });
      }

      print("Current Address: $currentAddress");
    } catch (e) {
      print("Error getting location: $e");
    }
  }
  int selectedCarouselIndex = 0;
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(UserController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(controller.latitude.value, controller.longitude.value),
                  zoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng( widget.lat, widget.lng),
                        child: _buildCHQMarker(),
                      ),
                      Marker(
                        point: LatLng(controller.latitude.value, controller.longitude.value),
                        child: _buildCHQMarker(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.white10,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.3, 0.6, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: EdgeInsets.all(height*0.02),
                  child: Column(
                    children: [
                      Text("CITY TOUR",
                          style: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                  color: Color(0xFF006597),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500))),
                      Text("Get closer to your destination",
                          style: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                  color: Color(0xFF006597),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600))),
                      Text("",),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _buildCustomMarker() {
    return Container(child: marker());
  }
  _builduserMarker() {
    return Container(child: markerA());
  }
  _buildCHQMarker() {
    return Container(child: markerB());
  }

  marker() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/distt.png',
        width: MediaQuery.of(context).size.width * 0.7,
      ),
    );
  }
  markerA() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/output-onlinegiftools.gif',
        width: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }
  markerB() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'images/marker.png',
        width: MediaQuery.of(context).size.width * 0.7,
      ),
    );
  }

}
