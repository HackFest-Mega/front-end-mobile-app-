import 'package:ambulance_service_automation/sendmessageApi.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({Key? key}) : super(key: key);
  static String phoneNumber = "";
  static String caseStory = "";

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Text dialogText = Text("");
  var errorstyle = TextStyle(fontSize: 20.0, color: Colors.white);
  Text text1 = Text("All fields are required");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Helper page")),
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
                  decoration:
                      const InputDecoration(hintText: 'enter your phone'),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  controller: messageController,
                  decoration: const InputDecoration(hintText: 'Enter the case'),
                  autofocus: true,
                ),
              ),
              Text(
                "$text1",
                style: errorstyle,
              ),
              TextButton(
                child: const Text("SUBMIT"),
                onPressed: () {
                  SendMessage.phoneNumber = phoneNumberController.text;
                  SendMessage.caseStory = messageController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SendApi()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
