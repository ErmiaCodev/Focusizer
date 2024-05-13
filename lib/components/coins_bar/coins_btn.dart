import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';

class CoinsBtn extends StatelessWidget {
  const CoinsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (ModalRoute.of(context)?.settings.name != "/shop") {
          Navigator.of(context).pushNamed("/shop");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: Hive.box(coinsBoxName).listenable(),
            builder: (context, Box box, child) {
              return Text("${box.get('coins') ?? 0}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold));
            },
          ),
          const SizedBox(width: 5),
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amber.shade400),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.currency_pound,
                    size: 20,
                    color: Colors.black,
                  ))),
        ],
      ),
    );
  }
}
