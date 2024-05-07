import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/styles/global.dart';

class NoteSettingsDialog extends StatefulWidget {
  NoteSettingsDialog({required this.note, required this.index, super.key});

  final Note note;
  final int index;

  @override
  State<NoteSettingsDialog> createState() => _NoteSettingsDialog();
}


class _NoteSettingsDialog extends State<NoteSettingsDialog> {
  String name = "";
  String caption = "";


  @override
  void initState() {
    name = widget.note.name;
    caption = widget.note.caption;
    super.initState();
  }

  void deleteNote(Note note) {
    note.delete();
  }

  void updateNote(Note note) {
    note.name = name;
    note.caption = caption;
    note.save();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: 'note_settings_${widget.index}',
      child: Icon(Icons.settings),
      backgroundColor: Colors.teal.shade300,
      foregroundColor: Colors.white,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('تنظیمات یاداشت'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: TextEditingController(text: widget.note.name),
                decoration: const InputDecoration(
                  hintText: "نام",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: widget.note.caption),
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: "توضیحات",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
                onChanged: (value) {
                  setState(() {
                    caption = value;
                  });
                },
              )
            ],
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              backgroundColor: Colors.red.shade300,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context, 'Cancel');
                deleteNote(widget.note);
              },
              label: const Text('حذف', style: labelStyle),
            ),
            FloatingActionButton.extended(
              backgroundColor: Colors.teal.shade300,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context, 'OK');
                updateNote(widget.note);
              },
              label: const Text('ذخیره', style: labelStyle),
            ),
          ],
        ),
      ),
    );
  }
}
