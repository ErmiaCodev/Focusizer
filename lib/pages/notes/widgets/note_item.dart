import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/pages/notes/note_detail.dart';
import 'package:taskizer/pages/notes/widgets/note_settings_dialog.dart';
import 'package:taskizer/styles/global.dart';

class NoteItem extends StatelessWidget {
  NoteItem({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => NoteDetailPage(note: note)));
      },
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: itemBoxStyle,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(note.name, style: titleStyle),
                ),
                NoteSettingsDialog(note: note),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
