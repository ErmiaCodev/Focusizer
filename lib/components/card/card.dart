import 'package:flutter/material.dart';

const cardTitle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontFamily: 'Bach',
  fontWeight: FontWeight.bold,
);

const cardText = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  fontFamily: 'Bach'
);

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    this.subTitle = "",
    this.note = "",
    this.timestamp = "",
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subTitle;
  final String note;
  final String timestamp;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: <Color>[
                Colors.teal.shade500,
                Colors.cyan.shade600
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // const SizedBox(height: 10),
            // Text(
            //   subTitle,
            //   style: cardText,
            // ),
            const SizedBox(height: 10),
            Text(
              title,
              style: cardTitle,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                note,
                style: cardText,
              ),
              Text(
                timestamp,
                style: cardText,
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
