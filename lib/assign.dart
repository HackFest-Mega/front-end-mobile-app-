import 'package:ambulance_service_automation/assignDriverApi.dart';
import 'package:flutter/material.dart';

import 'authorizingHospitalUser.dart';

class AssignDriver extends StatefulWidget {
  const AssignDriver({Key? key}) : super(key: key);
  static late String driverId;
  static late String messageId;

  @override
  State<AssignDriver> createState() => _AssignDriverState();
}

class _AssignDriverState extends State<AssignDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Assign Driver")),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: AuthorizingHospitalUser
                      .hospitalResponse[1]["activedrivers"].length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                          )
                        ]),
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.all(10),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              AssignDriver.driverId = AuthorizingHospitalUser
                                  .hospitalResponse[1]["activedrivers"][index]
                                      ["id"]
                                  .toString();
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AssignDriverApi()),
                            );
                          },
                          child: Text(
                            AuthorizingHospitalUser.hospitalResponse[1]
                                    ["activedrivers"][index]["numberplate"] +
                                "\n\n" +
                                "Acitve: " +
                                AuthorizingHospitalUser.hospitalResponse[1]
                                        ["activedrivers"][index]["isactive"]
                                    .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue),
                          ),
                        )),
                      )),
            ),
          ],
        ))));
  }
}
