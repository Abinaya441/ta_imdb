import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ta_imdb/screens/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashPage> {
  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splash.jpg"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "images/tmdb_square.png",
                width: 600,
                height: 600,
              ),
              SizedBox(
                height: 50,
              ),
              CircularProgressIndicator(
                  strokeWidth: 10.0, color: Color.fromRGBO(1, 180, 228, 1)),
            ],
          ),
        ),
      ),
    );
  }
}
