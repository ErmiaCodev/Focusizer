import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({required this.callback, super.key});
  final Function(int) callback;

  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<TimeSelector> {
  int _value = 5;

  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
      min: 0,
      max: 30,
      initialValue: 5,
      appearance: CircularSliderAppearance(
          size: 279,
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
            progressBarWidth: 20,
            handlerSize: 4,
          )),
      innerWidget: (double value) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              "${value.toInt()} دقیقه",
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ))
          ],
        );
      },
      onChangeEnd: (double weight) {
        setState(() {
          var minutes = max(int.parse(weight.ceil().toString())-1, 0);
          _value = minutes;
          widget.callback(minutes);
        });
      },
    );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal.shade50,
      ),
      child: slider,
    );
  }
}
