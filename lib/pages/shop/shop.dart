import 'package:flutter/material.dart';
import 'package:taskizer/components/actions/theme_toggle.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/components/actions/coins_btn.dart';
import 'package:taskizer/pages/profile/profile.dart';
import 'package:taskizer/styles/global.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فروشگاه", style: appbarTitle),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: Theme.of(context).brightness == Brightness.dark
                ? darkGradient
                : brandGradient,
          ),
        ),
        actions: const [
          CoinsBtn(open: false),
          ThemeToggler(),
        ],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text("بزودی در بروزرسانی های بعدی", style: titleStyle.copyWith(
          color: (Theme.of(context).brightness == Brightness.dark) ? Colors.blueGrey.shade100 : Colors.blueGrey.shade700
        )),
      ),
    );
  }
}