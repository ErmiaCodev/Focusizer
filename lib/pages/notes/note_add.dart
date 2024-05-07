import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '/constants/db.dart';
import '/models/note.dart';
import '/styles/global.dart';

class AddNote extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddNote> {
  String name = "";
  String caption = "";

  void onFormSubmit() {
    Box<Note> contactsBox = Hive.box<Note>(notesBoxName);
    contactsBox.add(Note(name: name, caption: caption, date: DateTime.now()));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("افزودن  یاداشت", style: titleStyle),
          centerTitle: true,
          backgroundColor: Colors.teal.shade400,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    initialValue: "",
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      label: Text("تیتر")
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: "",
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "توضیحات",
                    ),
                    onChanged: (value) {
                      setState(() {
                        caption = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FloatingActionButton.extended(
                      heroTag: 'submitNote',
                      onPressed: onFormSubmit,
                      label: Text("ذخیره", style: labelStyle),
                      backgroundColor: Colors.teal.shade300,
                      foregroundColor: Colors.white,
                    )
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
