import 'dart:async';
import 'dart:convert';
import 'package:ambulance_service_automation/hospitalPage.dart';
import 'package:ambulance_service_automation/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthorizingHospitalUser extends StatefulWidget {
  const AuthorizingHospitalUser({Key? key}) : super(key: key);
  static late List hospitalResponse;
  @override
  State<AuthorizingHospitalUser> createState() =>
      _AuthorizingHospitalUserState();
}

class _AuthorizingHospitalUserState extends State<AuthorizingHospitalUser> {
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 7), onClose);
  }

  Future<void> onClose() async {
    var response = await http.post(
      Uri.https('ambulance-automation.herokuapp.com', 'core/login/'),
      body: {
        "username": LoginPage.username.toString(),
        "password": LoginPage.password.toString()
      },
    );
    print(response.body);
    final result = jsonDecode(response.body) as List;
    AuthorizingHospitalUser.hospitalResponse = result;
    if (AuthorizingHospitalUser.hospitalResponse.length == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HospitalPage()),
      );
    }
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
