import 'package:flutter/material.dart';
import 'package:taskizer/pages/timer/infoer/dropdown.dart';
import 'package:taskizer/styles/global.dart';

class Infoer extends StatefulWidget {
  const Infoer({required this.givenTitle, required this.onChange, super.key});

  final Function(String, String?) onChange;
  final String givenTitle;

  @override
  _Infoer createState() => _Infoer();
}

class _Infoer extends State<Infoer> {
  String? _topic;
  String _title = "";

  Future<void> _onEdit() async {
    await showDialog(
      context: context,
      builder: (context) {
        return _buildDialog();
      },
    );
  }

  Widget _buildDialog() {
    return AlertDialog(
      title: Text("ویرایش پروسه"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  label: Text("تیتر")),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
            SizedBox(height: 20),
            TopicsDropDown(onChange: (v) {
              setState(() {
                _topic = v;
              });
            }),
            SizedBox(height: 20),
            FloatingActionButton.extended(
              heroTag: 'submitNote',
              onPressed: () {
                if (_title.length > 0) {
                  widget.onChange(_title, _topic);
                  Navigator.of(context).pop();
                }
              },
              label: Text("ذخیره", style: labelStyle),
              backgroundColor: Colors.teal.shade300,
              foregroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onEdit,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
              color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.teal.shade300 : Colors.teal.shade50,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (widget.givenTitle == "" ) ? "موضوع" : "${widget.givenTitle}",
                style: TextStyle(
                    color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.white : Colors.teal.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(Icons.edit, color: (Theme.of(context).colorScheme.brightness == Brightness.dark) ? Colors.white : Colors.teal.shade800),
            ],
          ),
        ),
      ),
    );
  }
}
