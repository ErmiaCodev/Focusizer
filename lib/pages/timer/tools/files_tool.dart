import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/file.dart';
import 'package:taskizer/pages/files/file_detail.dart';
import 'package:taskizer/pages/timer/tools/tool_button.dart';

class FilesTool extends StatefulWidget {
  FilesTool({super.key});

  @override
  _NotesToolState createState() => _NotesToolState();
}

class _NotesToolState extends State<FilesTool> {
  Future<void> _onClick() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // insetPadding: EdgeInsets.zero,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // clipBehavior: Clip.antiAlias,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("فایل ها"),
                FloatingActionButton.small(
                  backgroundColor: Colors.teal.shade300,
                  foregroundColor: Colors.white,
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/files/add");
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
            content: ValueListenableBuilder(
              valueListenable: Hive.box<UserFile>(filesBoxName).listenable(),
              builder: (context, Box<UserFile> box, child) {
                if (box.values.isEmpty) {
                  return Container(
                    child: Text("فایلی وجود ندارد"),
                  );
                }
                return Container(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...box.values.map((file) {
                            return ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FileDetailPage(file: file)));
                              },
                              child: Text(file.name),
                            );
                          }),
                        ],
                      ),
                    ));
              },
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToolButton(
        icon: Icons.sticky_note_2, label: "فایل ها", onPressed: _onClick);
  }
}
