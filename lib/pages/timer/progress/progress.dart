import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:taskizer/constants/timer.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({super.key, required this.rem});

  final int? rem;

  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
        min: 0,
        max: max_mins.toDouble()*60,
        initialValue: rem!.toDouble(),
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
                  "${rem! ~/ 60}:${(rem! - (rem! ~/ 60).toInt() * 60).toString().padLeft(2, '0')}",
                  textDirection: TextDirection.rtl,
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
}
