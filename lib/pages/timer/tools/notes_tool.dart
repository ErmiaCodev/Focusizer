import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/pages/timer/tools/note_preview.dart';

class NotesTool extends StatefulWidget {
  NotesTool({super.key});

  @override
  _NotesToolState createState() => _NotesToolState();
}

class _NotesToolState extends State<NotesTool> {
  Future<void> _onClick() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            // clipBehavior: Clip.antiAlias,
            title: Text("یاداشت ها"),
            content: ValueListenableBuilder(
              valueListenable: Hive.box<Note>(notesBoxName).listenable(),
              builder: (context, Box<Note> box, child) {
                if (box.values.isEmpty) {
                  return Container(
                    child: Text("یاداشتی وجود ندارد"),
                  );
                }
                return Container(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...box.values.map((note) {
                          return TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotePreviewScreen(note: note)));
                            },
                            child: Text(note.name),
                          );
                        }),
                      ],
                    ),
                  )
                );
              },
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _onClick,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add),
            Text("یاداشت ها", style: TextStyle(fontSize: 14)),
          ],
        ));
  }
}
