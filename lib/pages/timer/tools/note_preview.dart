import 'package:flutter/material.dart';
import '/components/appbar/navbar.dart';
import '/models/note.dart';

class NotePreviewScreen extends StatelessWidget {
  const NotePreviewScreen({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar("${note.name}"),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Text("${note.caption}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}