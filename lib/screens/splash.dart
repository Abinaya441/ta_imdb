import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      //backgroundColor: Colors.black,
      //backgroundColor: Color.fromRGBO(246, 199, 0, 1),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splash.jpg"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/tmdb_square.png",
                width: 600,
                height: 600,
              ),
              SizedBox(
                height: 70,
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),
              //   color: Color.fromRGBO(246, 199, 0, 1),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Text("Internet Movie Database",
              //         style: GoogleFonts.lato(
              //           textStyle: TextStyle(color: Colors.black),
              //           fontSize: 30,
              //           fontWeight: FontWeight.bold,
              //         )),
              //   ),
              // ),
              Container(
                //padding: const EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(
                    strokeWidth: 10.0, color: Color.fromRGBO(1, 180, 228, 1)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
