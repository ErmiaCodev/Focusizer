import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({super.key, required this.rem, required this.max});
  final int? rem;
  final int max;

  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
      min: 0,
      max: max.toDouble(),
      initialValue: rem!.toDouble(),
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
                  "${rem! ~/ 60}:${(rem! - (rem! ~/ 60).toInt() * 60).toString().padLeft(2, '0')}",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ))
          ],
        );
      }
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
