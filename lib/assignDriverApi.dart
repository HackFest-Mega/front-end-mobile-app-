import 'dart:async';

import 'package:ambulance_service_automation/assign.dart';
import 'package:ambulance_service_automation/success.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssignDriverApi extends StatefulWidget {
  const AssignDriverApi({Key? key}) : super(key: key);

  @override
  State<AssignDriverApi> createState() => _AssignDriverApiState();
}

class _AssignDriverApiState extends State<AssignDriverApi> {
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 7), onClose);
  }

  Future<void> onClose() async {
    var response = await http.post(
      Uri.https('ambulance-automation.herokuapp.com', 'core/assign-message/'),
      body: {
        "id": AssignDriver.driverId,
        "sendermessage": AssignDriver.messageId
      },
    );
    // print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Success()),
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
                    child: Text("assigning user"),
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
