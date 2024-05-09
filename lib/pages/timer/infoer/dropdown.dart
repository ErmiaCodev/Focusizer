import 'package:flutter/material.dart';
import 'package:taskizer/constants/topics.dart';

class TopicsDropDown extends StatefulWidget {
  const TopicsDropDown({required this.onChange, super.key});

  final Function(String?) onChange;

  @override
  State<TopicsDropDown> createState() => _TopicsDropDownState();
}

class _TopicsDropDownState extends State<TopicsDropDown> {
  String? _selected;
  final List<TopicItem> _topics = topicsConstant;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: _dropDown(underline: Container()));
  }

  Widget _title(String val) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        val,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dropDown({
    Widget? underline,
    Widget? icon,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
        value: _selected,
        underline: underline,
        icon: icon,
        dropdownColor: dropdownColor,
        style: style,
        iconEnabledColor: iconEnabledColor,
        onChanged: (String? newValue) {
          setState(() {
            _selected = newValue;
            widget.onChange(newValue);
          });
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
        hint: Text("یک موضوع را انتخاب کنید", style: hintStyle),
        items: _topics
            .map(
              (topic) => DropdownMenuItem<String>(
                value: topic.uid,
                child: Text(topic.name),
              ),
            )
            .toList(),
      );
}
