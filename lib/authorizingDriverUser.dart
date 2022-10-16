import 'dart:async';
import 'dart:convert';

import 'package:ambulance_service_automation/driver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class AuthorizingDriver extends StatefulWidget {
  const AuthorizingDriver({Key? key}) : super(key: key);
  static late List driverResponse;

  @override
  State<AuthorizingDriver> createState() => _AuthorizingDriverState();
}

class _AuthorizingDriverState extends State<AuthorizingDriver> {
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 7), onClose);
  }

  Future<void> onClose() async {
    var response = await http.post(
      Uri.https('ambulance-automation.herokuapp.com', 'core/login-driver/'),
      body: {
        "username": LoginPage.username.toString(),
        "password": LoginPage.password.toString()
      },
    );
    print(response.body);
    final result = jsonDecode(response.body) as List;
    AuthorizingDriver.driverResponse = result;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DriverPage()),
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
