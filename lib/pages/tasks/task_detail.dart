import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:taskizer/constants/topics.dart';
import 'package:taskizer/styles/global.dart';
import '/components/appbar/navbar.dart';
import '/components/guard/guard.dart';
import '/models/task.dart';

class TaskDetailPage extends StatelessWidget {
  TaskDetailPage({required this.task, super.key});

  final Task task;

  Widget buildProgress(BuildContext context) {
    final slider = SleekCircularSlider(
        min: 0,
        max: task.duration.toDouble(),
        initialValue: task.duration.toDouble(),
        appearance: CircularSliderAppearance(
            size: 260,
            startAngle: 120,
            angleRange: 300,
            animationEnabled: true,
            customColors: CustomSliderColors(
              hideShadow: true,
              trackColor: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.green.shade300 :  Colors.green.shade200,
              dotColor: Theme.of(context).colorScheme.secondary,
              progressBarColor: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.teal.shade400 : Colors.teal.shade300,
            ),
            customWidths: CustomSliderWidths(
              trackWidth: 8,
              progressBarWidth: 18,
              handlerSize: 4,
            )),
        innerWidget: (double value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "${task.duration} min",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.green.shade50 : Colors.green.shade700,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        });

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.blueGrey.shade700 : Colors.green.shade50,
      ),
      child: slider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Guard(
      child: Scaffold(
        appBar: Navbar(task.name),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              buildProgress(context),
              SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("مدت پروسه", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue.shade100),
                    child: Text(
                      "${task.duration} دقیقه",
                      style: normTextStyle.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.blue.shade800
                            : Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("موضوع", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.red.shade100),
                    child: Text(
                      "${topicsMap[task.topic] ?? 'بدون موضوع'}",
                      style: normTextStyle.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.red.shade800
                            : Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ساعت شروع", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.green.shade100),
                    child: Text(
                      "${task.date.hour}:${task.date.minute}",
                      style: normTextStyle.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.green.shade700
                            : Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("تاریخ", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.amber.shade100),
                    child: Text(
                      "${task.date.year}/${task.date.month}/${task.date.day}",
                      style: normTextStyle.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.amber.shade900
                            : Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("سکه", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.green.shade100),
                    child: Text(
                      "${task.coins}",
                      style: normTextStyle.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.green.shade700
                            : Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("تمرکز عمیق", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.red.shade100),
                    child: Text(
                      "${task.deepFocus ? 'عمیق' : 'عادی'}",
                      style: normTextStyle.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.red.shade800
                            : Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
