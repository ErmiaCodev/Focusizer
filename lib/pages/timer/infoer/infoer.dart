import 'package:flutter/material.dart';

class Infoer extends StatefulWidget {
  const Infoer({super.key});

  @override
  _Infoer createState() => _Infoer();
}

class _Infoer extends State<Infoer> {
  String? topic;
  String title = "";

  Future<void> _onEdit() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ویرایش پروسه"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

              ],
            ),
          ),
        );
      },
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
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "موضوع",
                style: TextStyle(
                    color: Colors.teal.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(Icons.edit, color: Colors.teal.shade800),
            ],
          ),
        ),
      ),
    );
  }
}
