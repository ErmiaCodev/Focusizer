import 'dart:developer';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/styles/global.dart';

class MyDurationTimePicker extends StatefulWidget {
  MyDurationTimePicker({required this.onChange, super.key});
  final Function(int) onChange;

  @override
  _MyDurationTimePickerState createState() => _MyDurationTimePickerState();
}

class _MyDurationTimePickerState extends State<MyDurationTimePicker> {
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var resultingDuration = await showDurationPicker(
          context: context,
          initialTime: Duration(minutes: 30),
          baseUnit: BaseUnit.minute
        );
        setState(() {
          duration = resultingDuration?.inMinutes ?? 0;
        });
        widget.onChange(resultingDuration?.inMinutes ?? 0);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(
          (duration > 0) ? "$duration دقیقه"
              : "انتخاب زمان",
          style: normTextStyle,
        ),
      ),
    );
  }
}
