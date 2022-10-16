import 'package:ambulance_service_automation/addDriver.dart';
import 'package:ambulance_service_automation/assign.dart';
import 'package:ambulance_service_automation/authorizingHospitalUser.dart';
import 'package:ambulance_service_automation/editdriver.dart';
import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({Key? key}) : super(key: key);

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hospital User"),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddDriverPage()),
                  );
                },
                child: const Text("Add Driver")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.33,
              child: ListView.builder(
                  itemCount: AuthorizingHospitalUser
                      .hospitalResponse[2]["drivers"].length,
                  scrollDirection: Axis.horizontal,
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
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            children: [
                              const Text("\n\n"),
                              Text(
                                AuthorizingHospitalUser.hospitalResponse[2]
                                        ["drivers"][index]["numberplate"] +
                                    "\n\n" +
                                    "Acitve: " +
                                    AuthorizingHospitalUser.hospitalResponse[2]
                                            ["drivers"][index]["isactive"]
                                        .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue),
                              ),
                              const Text("\n\n"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditDriver()),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: Colors.purple,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
            const SizedBox(height: 25),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: AuthorizingHospitalUser
                          .hospitalResponse[0]["messages"].length,
                      itemBuilder: (context, index) => Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(
                                  AuthorizingHospitalUser.hospitalResponse[0]
                                      ["messages"][index]["message"]),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    child: Text("Assign"),
                                    value: 0,
                                  ),
                                  const PopupMenuItem(
                                    child: Text("Reject"),
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

                                    print("call");
                                  }
                                  if (result == 0) {
                                    setState(() {
                                      AssignDriver.messageId =
                                          AuthorizingHospitalUser
                                              .hospitalResponse[0]["messages"]
                                                  [index]["id"]
                                              .toString();
                                    });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AssignDriver()),
                                    );
                                    print("send");
                                  }
                                },
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ],
        ))));
  }
}
