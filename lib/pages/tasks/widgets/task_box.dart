import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/models/task.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Row(
            children: [
              Text(task.name),

            ],
          ),
        ),
      ),
    );
  }
}