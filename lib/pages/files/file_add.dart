import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/models/file.dart';
import '/constants/db.dart';
import '/models/note.dart';
import '/styles/global.dart';

class FileAddPage extends StatefulWidget {
  @override
  _FileAddPageState createState() => _FileAddPageState();
}

class _FileAddPageState extends State<FileAddPage> {
  String _name = "";

  void onFormSubmit() {
    Box<UserFile> filesBox = Hive.box<UserFile>(filesBoxName);
    filesBox.add(UserFile(name: _name, path: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("افزودن  فایل", style: titleStyle),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    label: Text("تیتر")),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),
              Flexible(
                  fit: FlexFit.loose,
                  child: FloatingActionButton.extended(
                    heroTag: 'submitNote',
                    onPressed: onFormSubmit,
                    label: Text("ذخیره", style: labelStyle),
                    backgroundColor: Colors.teal.shade300,
                    foregroundColor: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
