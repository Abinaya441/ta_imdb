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
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "images/foto.jpg",
                            width: 150,
                            height: 150,
                          )),
                      SizedBox(height: 50),
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
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
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
