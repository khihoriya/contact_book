import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'main.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return logger();
        },
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.all(100),
              child:
                  Lottie.asset("lottie/98306-contacts-book.json"),
            ))
          ],
        ));
  }
}
