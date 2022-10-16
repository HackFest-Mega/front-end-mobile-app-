import 'package:ambulance_service_automation/authorizingDriverUser.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(9.037339413913871, 38.76209433642164);
  Location _location = Location();
  static double currentlong = 0;
  static double currentlat = 0;
  @override
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location.onLocationChanged.listen((l) {
      currentlat = l.latitude!;
      currentlong = l.longitude!;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 14),
        ),
      );
    });
  }

  MapType selectedmaptype = MapType.normal;
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
        appBar: AppBar(title: const Text("Driver Page")),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialogFunc(
                    context,
                    AuthorizingDriver.driverResponse[0]["latitude"],
                    AuthorizingDriver.driverResponse[0]["longitude"],
                    "Severity Level " +
                        AuthorizingDriver.driverResponse[0]["severity_level"]
                            .toString());
              },
              child: Card(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset("assets/direction.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AuthorizingDriver.driverResponse[0]["message"]
                                .toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(51, 83, 176, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: width,
                            child: Text(
                              "Severity: " +
                                  AuthorizingDriver.driverResponse[0]
                                          ["severity_level"]
                                      .toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(51, 83, 176, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 16.0,
                ),
                mapType: selectedmaptype,
                myLocationEnabled: true,
              ),
            ),
          ],
        ))));
  }
}

showDialogFunc(context, latitude, longitude, pharmacName) {
  List<Marker> _markers = <Marker>[];
  _markers.add(Marker(
      markerId: MarkerId('1'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: pharmacName)));

  LatLng _kMapCenter = LatLng(latitude, longitude);
  CameraPosition _kInitialPosition = CameraPosition(
    target: _kMapCenter,
    zoom: 16.0,
  );

  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Color.fromRGBO(51, 83, 176, 1),
            title: Text(
              pharmacName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Serif"),
            ),
            content: GoogleMap(
              initialCameraPosition: _kInitialPosition,
              markers: Set<Marker>.of(_markers),
              mapType: MapType.hybrid,
              myLocationEnabled: true,
            ),
            actions: [
              Text(
                "press the marker and use google maps direction to reach address the issue",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "serif"),
              ),
              SizedBox(
                height: 4,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Center(
                    child: Text(
                  'back',
                  style: TextStyle(
                    color: Color.fromRGBO(51, 83, 176, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: "serif",
                  ),
                )),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => SideBarLayout()));
              //     },
              //     child: Text(
              //       'change filters',
              //       style: TextStyle(
              //           color: Color.fromRGBO(51, 83, 176, 1),
              //           fontStyle: FontStyle.italic,
              //           fontWeight: FontWeight.bold),
              //     ))
            ],
          )
      // builder: (context) {
      //   return Center(
      //     child: Material(
      //       type: MaterialType.transparency,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: Colors.white,
      //         ),
      //         padding: EdgeInsets.all(15),
      //         width: MediaQuery.of(context).size.width * 0.7,
      //         height: 400,
      //         child: Expanded(
      //             child: Container(
      //           color: Colors.blueGrey[900],
      //           child: GoogleMap(
      //             initialCameraPosition: _kInitialPosition,
      //             markers: Set<Marker>.of(_markers),
      //             mapType: MapType.hybrid,
      //             myLocationEnabled: true,
      //           ),
      //         )),
      //       ),
      //     ),
      //   );
      // }
      );
}
