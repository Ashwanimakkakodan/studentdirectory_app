import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:studentdirectory_app/home.dart';

class Student extends StatelessWidget {
  Student({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 6), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
    return Scaffold(
      body: Center(child: Lottie.asset("assets/studentlogin.json")),
    );
  }
}
