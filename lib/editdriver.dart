import 'package:flutter/material.dart';

class EditDriver extends StatefulWidget {
  const EditDriver({Key? key}) : super(key: key);

  @override
  State<EditDriver> createState() => _EditDriverState();
}

class _EditDriverState extends State<EditDriver> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Text dialogText = Text("");
  var errorstyle = TextStyle(fontSize: 20.0, color: Colors.white);
  Text text1 = Text("All fields are required");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hospital User")),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(hintText: 'Full Name'),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: 'Plate Number'),
                  autofocus: true,
                ),
              ),
              Text(
                "$text1",
                style: errorstyle,
              ),
              TextButton(
                child: const Text("SUBMIT"),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
