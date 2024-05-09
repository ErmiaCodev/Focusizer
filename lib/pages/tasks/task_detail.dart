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

  Widget buildProgress() {
    final slider = SleekCircularSlider(
        min: 0,
        max: task.duration.toDouble(),
        initialValue: task.duration.toDouble(),
        appearance: CircularSliderAppearance(
            size: 200,
            startAngle: 120,
            angleRange: 300,
            animationEnabled: true,
            customColors: CustomSliderColors(
              hideShadow: true,
              trackColor: Colors.green.shade200,
              dotColor: Color(0XFFFAFAFA),
              progressBarColor: Colors.teal.shade300,
            ),
            customWidths: CustomSliderWidths(
              trackWidth: 5,
              progressBarWidth: 15,
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
                      color: Colors.green.shade600,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        });

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal.shade50,
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
              buildProgress(),
              SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("مدت پروسه", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical:  8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue.shade100
                    ),
                    child: Text("${task.duration} دقیقه", style: normTextStyle),
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
                    padding: EdgeInsets.symmetric(vertical:  8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.red.shade100
                    ),
                    child: Text("${topicsMap[task.topic ?? 'nan']}", style: normTextStyle),
                  )
                ],
              ),
              SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("موضوع", style: titleStyle),
                  Container(
                    padding: EdgeInsets.symmetric(vertical:  8, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.green.shade100
                    ),
                    child: Text("${task.date.hour}:${task.date.minute}", style: normTextStyle)
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
