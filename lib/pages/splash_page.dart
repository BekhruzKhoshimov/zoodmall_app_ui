import 'dart:async';
import 'package:flutter/material.dart';

import 'home_page.dart';
class Splash_Page extends StatefulWidget {
  const Splash_Page({Key? key}) : super(key: key);

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}
class _Splash_PageState extends State<Splash_Page> {
  bool isLogged = true;
  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 2000), (timer) {
      if(isLogged) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                  height: 300,
                  image: AssetImage("assets/images/splash.jpg")),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text("Darhol xarid qilish va muddatli to'lov uchun ZoodPay'dan foydalaning",style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
  }

}

