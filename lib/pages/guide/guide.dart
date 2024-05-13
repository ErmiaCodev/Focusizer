import 'package:flutter/material.dart';
import '/pages/guide/model.dart';
import '/pages/guide/onboarding.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
        pages: [
          OnboardingPageModel(
            title: 'تمرکز یار',
            description:
                'برنامه ای برای سامان دهی امور',
            imageUrl: 'assets/icon/logo.png',
            bgColor: Colors.indigo,
          ),
          OnboardingPageModel(
            title: 'پروسه ها',
            description: 'مدت زمانی رو انتخاب کنید و روی آن متمرکز شوید',
            imageUrl: 'assets/storefront.png',
            bgColor: Colors.green,
          ),
          OnboardingPageModel(
            title: 'سکه و امتیاز',
            description: 'با تمرکز  سکه دریافت کنید و قابلیت های برنامه رو باز کنید',
            imageUrl: 'assets/coins.png',
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'یاداشت ها',
            description:
                'فرمول ها و نکات را برای خود یاداشت کنید و هنگام تمرکز استفاده کنید',
            imageUrl: 'assets/building.png',
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'فایل ها',
            description: 'فایل ها و جزوات را ذخیره کرده و هنگام مطالعه استفاده کنید',
            imageUrl: 'assets/scooter.png',
            bgColor: Colors.purple,
          ),
        ],
        onFinish: () {
          Navigator.of(context)
              .popAndPushNamed('/auth/login');
        },
        onSkip: () {
          Navigator.of(context)
              .popAndPushNamed('/auth/login');    
        },
      ),
    );
  }
}