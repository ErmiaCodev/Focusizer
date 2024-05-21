import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '/components/appbar/navbar.dart';
import '/constants/db.dart';
import '/models/task.dart';
import '/pages/tasks/widgets/task_box.dart';
import '/styles/global.dart';

class TaskItem {
  final Task task;
  final int index;

  TaskItem({required this.task, required this.index});
}

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar("پروسه ها"),
      body: CustomScrollView(
        slivers: [
          ValueListenableBuilder(
            valueListenable: Hive.box<Task>(tasksBoxName).listenable(),
            builder: (context, Box<Task> box, child) {
              if (box.values.isEmpty) {
                return SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("پروسه ای ایجاد نشده!!!", style: titleStyle)
                        ],
                      )
                    ]),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                      padding: EdgeInsets.all(10),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(isVisible: false),
                          title: ChartTitle(text: "نمودار پیشرفت"),
                          plotAreaBackgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.blueGrey.shade700 : Colors.white,
                          backgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.blueGrey.shade700 : Colors.white,
                          series: <LineSeries<TaskItem, int>>[
                            LineSeries<TaskItem, int>(
                                dataSource: <TaskItem>[
                                  ...(box.values.map((t) {
                                    final index =
                                        box.values.toList().indexOf(t);
                                    return TaskItem(task: t, index: index);
                                  }))
                                ],
                                color: Colors.green.shade300,
                                xValueMapper: (TaskItem ti, _) => ti.index,
                                yValueMapper: (TaskItem ti, _) =>
                                    ti.task.duration,
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ])),
                  const SizedBox(height: 20),
                  ...box.values.toList().reversed.map((task) {
                    final index = box.values.toList().indexOf(task);
                    return TaskBox(task: task, index: index);
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
