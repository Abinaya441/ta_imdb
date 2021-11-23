import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    "images/tom.png",
                    width: 250,
                    height: 250,
                  )),
              SizedBox(height: 20),
              Text(
                'Muhammad Abinaya Isaqofi',
                style: GoogleFonts.lobster(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(13, 37, 63, 1)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '21120119130039',
                style: GoogleFonts.lobster(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(1, 180, 228, 1)),
              ),
              SizedBox(height: 125),
              Text(
                'Powered By',
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                    fontWeight: FontWeight.normal,
                    fontSize: 31,
                    color: Color.fromRGBO(144, 206, 161, 1)),
              ),
              //SizedBox(height: 10),
              SizedBox(
                child: Image.asset("images/tmdb.png"),
                height: 50,
              )
            ],
          ),
        ));
  }
}
