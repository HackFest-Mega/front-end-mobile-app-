import 'package:flutter/material.dart';

class AddDriverPage extends StatefulWidget {
  const AddDriverPage({Key? key}) : super(key: key);

  @override
  State<AddDriverPage> createState() => _AddDriverPageState();
}

class _AddDriverPageState extends State<AddDriverPage> {
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
