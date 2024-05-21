import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/styles/global.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar("درباره برنامه"),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icon/logo.png", height: 180, width: 180)
                ],
              ),
              const Text("تمر کز  یار",
                  style: titleStyle, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              const Text(
                "این برنامه جهت کمک به برنامه ریزی دانش آموزان و زمان بندی بهتر طراحی شده. درکنار تایمر تعدادی امکانات قرار گرفته که با افزایش امتیاز فعال میشود.",
                style: normTextStyle,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("طراح و سازنده",
                      style:
                          normTextStyle.copyWith(fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: () {
                        final Uri url =
                            Uri.parse('https://ErmiaCodev.github.io/Fa/');
                        launchUrl(url);
                      },
                      child: Text("ارمیا مقدمی",
                          style: normTextStyle.copyWith(
                              fontWeight: FontWeight.bold)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
