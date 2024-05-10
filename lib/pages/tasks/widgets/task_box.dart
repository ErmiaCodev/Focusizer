import 'package:flutter/material.dart';
import '/models/task.dart';
import '/pages/tasks/task_detail.dart';
import '/styles/global.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskDetailPage(task: task)));
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.teal.shade200)
            ),
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
                    heroTag: 'task_trash_${task.name}',
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      task.delete();
                    },
                    child: const Icon(Icons.recycling),
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
