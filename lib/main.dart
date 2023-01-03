import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:zoodmall_app_ui/pages/button.dart';
import 'package:zoodmall_app_ui/pages/home_page.dart';
import 'package:zoodmall_app_ui/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Splash_Page(),
    );
  }
}

 const defaultDuration = Duration(hours: 2, minutes: 30);
class ExampleSlideCountdown extends StatelessWidget {
  const ExampleSlideCountdown({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SlideCountdownSeparated(
              duration: defaultDuration,
            ),
          ],
        ),
      ),
    );
  }
}