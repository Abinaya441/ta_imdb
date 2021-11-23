import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Detail1Page extends StatefulWidget {
  final int item;
  final String title;
  const Detail1Page({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  _Detail1PageState createState() => _Detail1PageState();
}

class _Detail1PageState extends State<Detail1Page> {
  late Future<Show> shows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              elevation: 3,
              color: Color.fromRGBO(13, 37, 63, 1),
              child: BackButton(
                color: Color.fromRGBO(1, 180, 228, 1),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: FutureBuilder<Show>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Image.network('https://image.tmdb.org/t/p/original' +
                        snapshot.data!.backdrop_path),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    widget.title,
                                    style: GoogleFonts.bebasNeue(
                                        textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(13, 37, 63, 1)),
                                        fontSize: 35),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  snapshot.data!.tagline,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Color.fromRGBO(13, 37, 63, 1),
                                          fontSize: 15)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                //padding: const EdgeInsets.only(left: 20, right: 20),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data!.vote_average} ⭐',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bebasNeue(
                                          textStyle: TextStyle(
                                              color:
                                                  Color.fromRGBO(13, 37, 63, 1),
                                              fontSize: 22)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  snapshot.data!.overview,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(13, 37, 63, 1))),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  snapshot.data!.overview,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(13, 37, 63, 1))),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  snapshot.data!.overview,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(13, 37, 63, 1))),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  snapshot.data!.overview,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(13, 37, 63, 1))),
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Wrong'),
                );
              }
              return const CircularProgressIndicator(
                color: Colors.transparent,
              );
            },
            future: shows,
          ),
        ));
  }
}

//API
class Show {
  final int id;
  final String backdrop_path;
  final String overview;
  final String tagline;
  final num vote_average;

  Show({
    required this.id,
    required this.backdrop_path,
    required this.overview,
    required this.tagline,
    required this.vote_average,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      backdrop_path: json['backdrop_path'],
      overview: json['overview'],
      tagline: json['tagline'],
      vote_average: json['vote_average'],
    );
  }
}

Future<Show> fetchShows(id) async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/$id?api_key=861613aa2a7de68cd25a126a35966d27&language=en-US'));

  if (response.statusCode == 200) {
    return Show.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load description');
  }
}
