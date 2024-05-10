import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/components/appbar/navbar.dart';
import '../home/home_page.dart';
import '/store/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _name = "";
  var storage = const FlutterSecureStorage();

  Future<void> saveUser(String username) async {
    await storage.write(key: 'token', value: username);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        return Scaffold(
          appBar: const Navbar("ورود به برنامه"),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "نام شما",
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.teal.shade300,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          if (_name != '') {
                            ref.read(userProvider.notifier).updateLogin(_name);
                            saveUser(_name);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (builder) => const HomePage()));
                          }
                        },
                        label: Text("ورود",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
