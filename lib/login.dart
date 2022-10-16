import 'package:ambulance_service_automation/authorizingDriverUser.dart';
import 'package:ambulance_service_automation/authorizingHospitalUser.dart';
import 'package:ambulance_service_automation/driver.dart';
import 'package:ambulance_service_automation/fetchLocation.dart';
import 'package:ambulance_service_automation/hospitalPage.dart';
import 'package:ambulance_service_automation/loadingHospital.dart';
import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static late String username;
  static late String password;
  void clearText() {
    usernameController.text = "";
    passwordController.text = "";
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextStyle style = TextStyle(fontSize: 20.0);
TextStyle errorStyle = TextStyle(color: Colors.white);

class _LoginPageState extends State<LoginPage> {
  final username = TextField(
    controller: usernameController,
    obscureText: false,
    style: style,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
      labelText: "User name",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );
  final password = TextField(
    controller: passwordController,
    obscureText: true,
    style: style,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
      labelText: "Password",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 25),
                    const Text("Ambulance Automation",
                        style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 25.0,
                    ),
                    username,
                    SizedBox(
                      height: 25.0,
                    ),
                    password,
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "incorrect credentials",
                      style: errorStyle,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextButton(
                        onPressed: () {
                          LoginPage.username =
                              usernameController.text.toString();
                          LoginPage.password =
                              passwordController.text.toString();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AuthorizingHospitalUser()),
                          );
                        },
                        child: const Text("Login as Hospital user")),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          Divider(),
                          InkWell(
                            child: Text(
                              "Login as driver",
                              style: TextStyle(color: Colors.cyan),
                            ),
                            onTap: () {
                              LoginPage.username =
                                  usernameController.text.toString();
                              LoginPage.password =
                                  passwordController.text.toString();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AuthorizingDriver()),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          Divider(),
                          InkWell(
                            child: BlinkText(
                              'Report a case',
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.redAccent),
                              endColor: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SplashScreen()),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      )),
    );
  }
}
