import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/pages/tasks/widgets/task_add_dialog.dart';
import '/components/appbar/navbar.dart';
import '/constants/db.dart';
import '/models/task.dart';
import '/pages/tasks/widgets/task_box.dart';
import '/styles/global.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar("تسک ها"),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("تسک ها", style: titleStyle),
                      FloatingActionButton.small(
                        child: Icon(Icons.add),
                        backgroundColor: Colors.teal.shade300,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/tasks/add');
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box<Task>(tasksBoxName).listenable(),
            builder: (context, Box<Task> box, child) {
              if (box.values.isEmpty) {
                return SliverPadding(
                  padding: EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("تسکی ایجاد نشده!!!", style: titleStyle)
                        ],
                      )
                    ]),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildListDelegate([
                  ...box.values.map((task) {
                    return TaskBox(task: task);
                  })
                ]),
              );
            },
          ),
        ],
      ),
    );
  }
}
