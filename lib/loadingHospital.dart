import 'dart:async';
import 'dart:convert';

import 'package:ambulance_service_automation/fetchLocation.dart';
import 'package:ambulance_service_automation/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadHospitalData extends StatefulWidget {
  const LoadHospitalData({Key? key}) : super(key: key);
  static late List hospitalData;

  @override
  State<LoadHospitalData> createState() => _LoadHospitalDataState();
}

class _LoadHospitalDataState extends State<LoadHospitalData> {
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 7), onClose);
  }

  onClose() async {
    //var url = Uri.parse('https://bsc-newapi.herokuapp.com/bsc/kpi/');
    //https://pms-apis.herokuapp.com
    var response = await http.get(
      Uri.https('ambulance-automation.herokuapp.com', '/core/active/'),
    );

    final result = jsonDecode(response.body) as List;
    LoadHospitalData.hospitalData = result;

    // for (int i = 0; i < result.length; i++) {
    //   ApiLoading.kpis.add(result[i]['kpi_name']);
    // }
    // print(ApiLoading.data);
    print(LoadHospitalData.hospitalData);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelperPage()),
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
                    child: Text("Calculating Distance"),
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
