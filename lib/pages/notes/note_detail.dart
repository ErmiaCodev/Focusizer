import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/helpers/timer.dart';
import '/components/appbar/navbar.dart';
import '/components/guard/guard.dart';
import '/models/note.dart';

class NoteDetailPage extends StatelessWidget {
  NoteDetailPage({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Guard(
      child: Scaffold(
        appBar: Navbar(note.name),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...note.caption.split("\n").map((line) {
                return Directionality(
                  textDirection: hasSharedAlpha(line)
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Text(line,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
