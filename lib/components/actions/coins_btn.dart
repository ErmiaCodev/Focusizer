import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';

class CoinsBtn extends StatelessWidget {
  const CoinsBtn({this.open = true, super.key});

  final bool open;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (ModalRoute.of(context)?.settings.name != "/shop" && open) {
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
              return Padding(
                  padding: const EdgeInsets.only(top: 5.5),
                  child: Text("${box.get('coins') ?? 0}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)));
            },
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Image.asset("assets/coin.png", height: 22)
          ),
        ],
      ),
    );
  }
}
