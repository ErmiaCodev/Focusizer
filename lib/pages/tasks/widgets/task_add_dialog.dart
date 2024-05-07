import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/styles/global.dart';

class TaskAddDialog extends StatefulWidget {
  TaskAddDialog({super.key});

  State<TaskAddDialog> createState() => _TaskAddDialog();
}


class _TaskAddDialog extends State<TaskAddDialog> {
  String name   = "";
  String caption = "";

  void createNote() {
    Box<Task> contactsBox = Hive.box<Task>(tasksBoxName);
    contactsBox.add(Task(name: name, caption: caption, duration: 0, date: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      child: Icon(Icons.add),
      backgroundColor: Colors.teal.shade300,
      foregroundColor: Colors.white,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('افزودن تسک'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
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
              backgroundColor: Colors.orange.shade300,
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              label: const Text('انصراف', style: labelStyle),
            ),
            FloatingActionButton.extended(
              backgroundColor: Colors.teal.shade300,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context, 'OK');
                createNote();
              },
              label: const Text('ذخیره', style: labelStyle),
            ),
          ],
        ),
      ),
    );
  }
}