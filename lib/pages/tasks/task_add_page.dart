import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/components/dropdown/dropdown.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/pages/tasks/widgets/dropdown.dart';
import 'package:taskizer/pages/tasks/widgets/time_picker.dart';
import '/constants/db.dart';
import '/styles/global.dart';

class TaskAddPage extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _TaskAddPageState createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  String _name = "";
  String _caption = "";
  String? _topic;
  int _duration = 0;

  void onFormSubmit() {
    Box<Task> tasksBox = Hive.box<Task>(tasksBoxName);
    tasksBox.add(Task(name: _name, topic: _topic, caption: _caption, duration: _duration, date: DateTime.now()));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("افزودن  تسک", style: titleStyle),
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
                        _name = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  MyDurationTimePicker(
                    onChange: (duration) {
                      setState(() {
                        _duration = duration;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TopicsDropDown(onChange: (value) {
                    _topic = value;
                  }),
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
                        _caption = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Flexible(
                      fit: FlexFit.loose,
                      child: FloatingActionButton.extended(
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
