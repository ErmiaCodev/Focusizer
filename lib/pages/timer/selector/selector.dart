import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:taskizer/constants/timer.dart';

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
      max: max_mins.toDouble(),
      initialValue: 5.5,
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
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "${_value} دقیقه",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.green.shade50 : Colors.green.shade700,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        );
      },
      onChange: (weight) {
        setState(() {
          var minutes = int.parse(weight.ceil().toString());
          _value = minutes.toInt();
        });
      },
      onChangeEnd: (double weight) {
        widget.callback(_value);
      },
    );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.blueGrey.shade700 : Colors.green.shade50,
      ),
      child: slider,
    );
  }
}
