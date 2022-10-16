import 'dart:async';
import 'dart:convert';

import 'package:ambulance_service_automation/fetchLocation.dart';
import 'package:ambulance_service_automation/helper.dart';
import 'package:ambulance_service_automation/location_service.dart';
import 'package:ambulance_service_automation/sendmessage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendApi extends StatefulWidget {
  const SendApi({Key? key}) : super(key: key);

  @override
  State<SendApi> createState() => _SendApiState();
}

class _SendApiState extends State<SendApi> {
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 7), onClose);
  }

  Future<void> onClose() async {
    var response = await http.post(
      Uri.https('ambulance-automation.herokuapp.com', 'core/message/'),
      body: {
        "latitude": UserLocation.lat.toString(),
        "longitude": UserLocation.long.toString(),
        "country": HelperPage.country.toString(),
        "street": HelperPage.street.toString(),
        "name": HelperPage.name.toString(),
        "area": HelperPage.postalCode.toString(),
        "message": SendMessage.caseStory.toString(),
        "isactive": true.toString(),
        "severity_level": "High",
        "hospital": HelperPage.hospitalId.toString(),
        "phonenumber": SendMessage.phoneNumber.toString()
      },
    );
    print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    child: Text("sending message"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
