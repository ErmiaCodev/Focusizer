import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/appbar/navbar.dart';
import '/components/card/card.dart';
import '/components/guard/guard.dart';
import '/screens/profile.dart';
import '/store/auth.dart';
import '/styles/global.dart';

final titleStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  // color: Colors.blueGrey.shade700,
);

final emphesizeStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.teal.shade300,
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Guard(
      child: Scaffold(
        appBar: AppBar(
          title: Text("خانه", style: appbarTitle),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: brandGradient,
            ),
          ),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => ProfilePage())),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "سلام ",
                        style: titleStyle,
                      ),
                      Text(
                        " ${user.name} ",
                        style: emphesizeStyle,
                      ),
                      Text(
                        "خوش آومدی!",
                        style: titleStyle,
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ItemCard(
                    color: Colors.teal,
                    title: "برنامه ریزی سفر",
                    note: "کل پلن ها:",
                    timestamp: "هیچی",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => ProfilePage()));
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ItemCard(
                    color: Colors.teal,
                    title: "مدیریت تسک ها",
                    note: "کل تسک ها:",
                    timestamp: "هیچی",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => ProfilePage()));
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ItemCard(
                    color: Colors.deepPurple,
                    title: "یاداشت های من",
                    note: "کل یاداشت ها:",
                    timestamp: "هیچی",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => ProfilePage()));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
