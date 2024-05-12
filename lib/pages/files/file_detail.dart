import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/appbar/navbar.dart';
import '/components/guard/guard.dart';
import '/models/file.dart';

class FileDetailPage extends StatelessWidget {
  FileDetailPage({required this.file, super.key});

  final UserFile file;

  @override
  Widget build(BuildContext context) {
    return Guard(
        child: Scaffold(
      appBar: Navbar(file.name),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(file.name, style: TextStyle(fontSize: 18))
          ],
        ),
      )
    ));
  }
}
