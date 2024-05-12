import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/task.dart';
import '/pages/home/feature.dart';
import '/components/appbar/navbar.dart';
import '/components/card/card.dart';
import '/components/guard/guard.dart';
import '../profile/profile.dart';
import '/store/auth.dart';
import '/styles/global.dart';

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
            title: Text("تمرکز یار", style: appbarTitle),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: brandGradient,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed("/points");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: Hive.box(coinsBoxName).listenable(),
                        builder: (context, Box box, child) {
                          return Text("${box.get('coins') ?? 0}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold));
                        },
                      ),
                      SizedBox(width: 5),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow.shade500),
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.currency_bitcoin,
                                size: 20,
                                color: Colors.black,
                              ))),
                    ],
                  ))
            ],
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (builder) => ProfilePage())),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Task>(tasksBoxName).listenable(),
                      builder: (context, Box<Task> box, child) {
                        if (box.values.isEmpty) {
                          return ItemCard(
                            color: Colors.teal,
                            title: "تمرکز کنید!",
                            note: "کل تسک ها:",
                            timestamp: "هیچی",
                            onTap: () {
                              Navigator.of(context).pushNamed('/timer');
                            },
                          );
                        }

                        return ItemCard(
                          color: Colors.teal,
                          title: "تمرکز کنید!",
                          note: "کل پروسه ها:",
                          timestamp: "${box.values.length}",
                          onTap: () {
                            Navigator.of(context).pushNamed('/timer');
                          },
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "سلام ",
                          style: titleStyle,
                        ),
                        Text(
                          " ${user.name} ",
                          style: emphesizeStyle,
                        ),
                        const Text(
                          "خوش آومدی!",
                          style: titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        FeatureBox(
                          title: "پروسه ها",
                          icon: "assets/icon/more.png",
                          link: "/tasks",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FeatureBox(
                          title: "یاداشت ها",
                          icon: "assets/icon/first.png",
                          link: "/notes",
                        ),
                        FeatureBox(
                          title: "فایل ها",
                          icon: "assets/icon/third.png",
                          link: "/files",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FeatureBox(
                          title: "فروشگاه",
                          icon: "assets/storefront.png",
                          link: "/tasks",
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            ],
          )),
    );
  }
}
