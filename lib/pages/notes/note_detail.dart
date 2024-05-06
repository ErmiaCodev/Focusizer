import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/components/guard/guard.dart';
import 'package:taskizer/models/note.dart';

class NoteDetailPage extends StatelessWidget {
  NoteDetailPage({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Guard(
        child: Scaffold(
      appBar: Navbar(note.name),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(note.caption, style: TextStyle(fontSize: 18))
          ],
        ),
      )
    ));
  }
}
