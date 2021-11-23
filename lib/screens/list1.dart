import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ta_imdb/screens/detail1.dart';

class List1Page extends StatefulWidget {
  const List1Page({Key? key}) : super(key: key);

  @override
  _List1PageState createState() => _List1PageState();
}

class _List1PageState extends State<List1Page> {
  late Future<List<MovieNow>> moviesNow;
  late Future<List<MoviePop>> moviesPop;

  @override
  void initState() {
    super.initState();
    moviesNow = fetchMoviesNow();
    moviesPop = fetchMoviesPop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(
            //   height: 100,
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Now Playing',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(13, 37, 63, 1)),
              ),
            ),
            //HORIZONTAL
            FutureBuilder(
              builder: (context, AsyncSnapshot<List<MovieNow>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail1Page(
                                              item: snapshot.data![index].id,
                                              title: snapshot.data![index]
                                                  .original_title)));
                                },
                                child: Card(
                                  color: Color.fromRGBO(1, 180, 228, 1),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    height: 200,
                                    width: 120,
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Card(
                                              semanticContainer: true,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/original' +
                                                    snapshot.data![index]
                                                        .poster_path,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3, right: 3),
                                              child: Text(
                                                snapshot.data![index]
                                                    .original_title,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.bebasNeue(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                            height: 20,
                                            width: 50,
                                            margin: EdgeInsets.only(
                                                left: 5, top: 5),
                                            decoration: new BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius: new BorderRadius
                                                        .all(
                                                    Radius.elliptical(10, 10))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                '${snapshot.data![index].vote_average} ⭐',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                return const CircularProgressIndicator(
                  color: Colors.transparent,
                );
              },
              future: moviesNow,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Popular',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(13, 37, 63, 1)),
              ),
            ),
            //VERTIKAL
            Flexible(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<List<MoviePop>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail1Page(
                                        item: snapshot.data![index].id,
                                        title: snapshot
                                            .data![index].original_title)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 15, right: 15),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Color.fromRGBO(1, 180, 228, 1),
                              child: Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/original' +
                                          snapshot.data![index].poster_path,
                                      fit: BoxFit.fill,
                                      height: 150,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].original_title,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '${snapshot.data![index].vote_average} ⭐',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    //);
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something wrong'),
                    );
                  }
                  return const CircularProgressIndicator(
                    color: Colors.transparent,
                  );
                },
                future: moviesPop,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//API
class MovieNow {
  final int id;
  final String original_title;
  final String poster_path;
  final num vote_average;

  MovieNow({
    required this.id,
    required this.original_title,
    required this.poster_path,
    required this.vote_average,
  });

  factory MovieNow.fromJson(Map<String, dynamic> json) {
    return MovieNow(
      id: json['id'],
      original_title: json['original_title'],
      poster_path: json['poster_path'],
      vote_average: json['vote_average'],
    );
  }
}

Future<List<MovieNow>> fetchMoviesNow() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?api_key=861613aa2a7de68cd25a126a35966d27&language=en-US&page=1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['results'] as List;
    return topShowsJson.map((show) => MovieNow.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

class MoviePop {
  final int id;
  final String original_title;
  final String poster_path;
  final String overview;
  final num vote_average;

  MoviePop({
    required this.id,
    required this.original_title,
    required this.poster_path,
    required this.overview,
    required this.vote_average,
  });

  factory MoviePop.fromJson(Map<String, dynamic> json) {
    return MoviePop(
      id: json['id'],
      original_title: json['original_title'],
      poster_path: json['poster_path'],
      overview: json['overview'],
      vote_average: json['vote_average'],
    );
  }
}

Future<List<MoviePop>> fetchMoviesPop() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=861613aa2a7de68cd25a126a35966d27&language=en-US&page=1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['results'] as List;
    return topShowsJson.map((show) => MoviePop.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
