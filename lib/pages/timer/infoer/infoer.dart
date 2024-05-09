import 'package:flutter/material.dart';
import 'package:taskizer/styles/global.dart';

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
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      label: Text("تیتر")
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "توضیحات",
                  ),
                ),
                SizedBox(height: 20),
                Flexible(
                    fit: FlexFit.loose,
                    child: FloatingActionButton.extended(
                      heroTag: 'submitNote',
                      onPressed: () {},
                      label: Text("ذخیره", style: labelStyle),
                      backgroundColor: Colors.teal.shade300,
                      foregroundColor: Colors.white,
                    )
                )
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
