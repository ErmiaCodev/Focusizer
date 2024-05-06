import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/pages/tasks/widgets/task_box.dart';
import 'package:taskizer/styles/global.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar("تسک ها"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("تسک ها", style: titleStyle),
                FloatingActionButton.small(
                  backgroundColor: Colors.teal.shade300,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.add),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: Hive.box<Task>(tasksBoxName).listenable(),
              builder: (context, Box<Task> box, child) {
                if (box.values.isEmpty) {
                  return Expanded(child: Center(
                    child: Text("تسکی ساخته نشده!", style: labelStyle),
                  ));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      Task task = box.values.elementAt(index);
                      return TaskBox(task: task);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
