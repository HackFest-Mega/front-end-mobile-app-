import 'dart:math';

import 'package:ambulance_service_automation/fetchLocation.dart';
import 'package:ambulance_service_automation/loadingHospital.dart';
import 'package:ambulance_service_automation/location_service.dart';
import 'package:ambulance_service_automation/login.dart';
import 'package:ambulance_service_automation/sendmessage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperPage extends StatefulWidget {
  const HelperPage({Key? key}) : super(key: key);
  static late String country;
  static late String name;
  static late String street;
  static late String postalCode;
  static late int hospitalId;

  @override
  State<HelperPage> createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  onClose() async {}
  TextStyle style = const TextStyle(fontSize: 20.0);
  String country = '';
  String name = '';
  String street = '';
  String postalCode = '';
  String? dvalue;

  @override
  void initState() {
    super.initState();

    getLocation();
    finalDistance();
  }

  late List locationNames;
  late List phoneNumbers;
  late List hospitalIds;
  List<dynamic> distances = <dynamic>[];
  double calculateDistance(currlat, currlong, latp, longp) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latp - currlat) * p) / 2 +
        c(currlat * p) * c(latp * p) * (1 - c((longp - currlong) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  late Map pair;
  void finalDistance() {
    for (int i = 0; i < LoadHospitalData.hospitalData.length; i++) {
      distances.add(calculateDistance(
          UserLocation.lat,
          UserLocation.long,
          LoadHospitalData.hospitalData[i]["latitude"],
          LoadHospitalData.hospitalData[i]["longitude"]));
    }
    var indexdistance1 = distances.indexOf(distances.cast<num>().reduce(min));
    distances[indexdistance1] = 1000000000000000000;

    var indexdistance2 = distances.indexOf(distances.cast<num>().reduce(min));
    distances[indexdistance2] = 1000000000000000000;

    var indexdistance3 = distances.indexOf(distances.cast<num>().reduce(min));
    distances[indexdistance3] = 1000000000000000000;

    var indexdistance4 = distances.indexOf(distances.cast<num>().reduce(min));
    distances[indexdistance4] = 1000000000000000000;
    var indexdistance5 = distances.indexOf(distances.cast<num>().reduce(min));

    // late List indexs = [
    //   indexdistance1,
    //   indexdistance2,
    //   indexdistance3,
    //   indexdistance4,
    //   indexdistance5
    // ];'
    locationNames = [
      LoadHospitalData.hospitalData[indexdistance1]["name"],
      LoadHospitalData.hospitalData[indexdistance2]["name"],
      LoadHospitalData.hospitalData[indexdistance2]["name"],
      LoadHospitalData.hospitalData[indexdistance3]["name"],
      LoadHospitalData.hospitalData[indexdistance4]["name"]
    ];
    phoneNumbers = [
      LoadHospitalData.hospitalData[indexdistance1]["phonenumber"],
      LoadHospitalData.hospitalData[indexdistance2]["phonenumber"],
      LoadHospitalData.hospitalData[indexdistance2]["phonenumber"],
      LoadHospitalData.hospitalData[indexdistance3]["phonenumber"],
      LoadHospitalData.hospitalData[indexdistance4]["phonenumber"]
    ];
    hospitalIds = [
      LoadHospitalData.hospitalData[indexdistance1]["id"],
      LoadHospitalData.hospitalData[indexdistance2]["id"],
      LoadHospitalData.hospitalData[indexdistance2]["id"],
      LoadHospitalData.hospitalData[indexdistance3]["id"],
      LoadHospitalData.hospitalData[indexdistance4]["id"],
    ];
  }

  Future<void> getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);

    print(placemark[0].country);
    print(placemark[0].name);
    print(placemark[0].street);
    print(placemark[0].postalCode);

    setState(() {
      country = placemark[0].country!;
      name = placemark[0].name!;
      street = placemark[0].street!;
      postalCode = placemark[0].administrativeArea!;
      HelperPage.name = placemark[0].name!;
      HelperPage.country = placemark[0].country!;
      HelperPage.street = placemark[0].street!;
      HelperPage.postalCode = placemark[0].postalCode!;
    });
  }

  Text dialogText = Text("");
  var errorstyle = TextStyle(fontSize: 20.0, color: Colors.white);
  Text text1 = Text("All fields are required");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Helper Page")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                          );
                        },
                        child: const Text("Referesh Location")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Home")),
                  ],
                ),
              )),
              const SizedBox(height: 25),
              Text("Lat : ${UserLocation.lat}"),
              Text("Long : ${UserLocation.long}"),
              Text("Country : $country"),
              Text("Name : $name"),
              Text("Street : $street"),
              Text("Area : $postalCode"),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(locationNames[index].toString()),
                                trailing: PopupMenuButton(
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      child: Text("Send Message"),
                                      value: 0,
                                    ),
                                    const PopupMenuItem(
                                      child: Text("Call"),
                                      value: 1,
                                    ),
                                  ],
                                  onSelected: (result) {
                                    if (result == 1) {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const Deleting()),
                                      // );
                                      // ignore: deprecated_member_use
                                      launch("tel://" +
                                          phoneNumbers[index].toString());

                                      print("call");
                                    }
                                    if (result == 0) {
                                      HelperPage.hospitalId =
                                          hospitalIds[index];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SendMessage()),
                                      );
                                      print("send");
                                    }
                                  },
                                ),
                              ),
                            )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
