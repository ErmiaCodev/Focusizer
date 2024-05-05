import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final String title;
  final String icon;
  final String link;

  const FeatureBox({
    required this.link,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (link != "") {
            Navigator.of(context).pushNamed(link);
          }
        },
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icon,
                      height: 50,
                      width: 50,
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.blueGrey.shade300)),
          ),
        ),
      ),
    );
  }
}
