import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/styles/global.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: itemBoxStyle,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(task.name, style: titleStyle),
                  ),
                  FloatingActionButton.small(
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    onPressed: () {},
                    child: Icon(Icons.recycling),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
