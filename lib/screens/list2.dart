import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ta_imdb/screens/detail.dart';

class List2Page extends StatefulWidget {
  const List2Page({Key? key}) : super(key: key);

  @override
  _List2PageState createState() => _List2PageState();
}

class _List2PageState extends State<List2Page> {
  late Future<List<MovieTop>> moviesTop;

  @override
  void initState() {
    super.initState();
    moviesTop = fetchMoviesTop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Top Movies of All Time',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(13, 37, 63, 1)),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  builder: (context, AsyncSnapshot<List<MovieTop>> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ListView.builder(
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
                                padding: const EdgeInsets.only(bottom: 5),
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
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
                                      Container(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data![index].original_title,
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.bebasNeue(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              '${snapshot.data![index].vote_average} ⭐',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something wrong'),
                      );
                    }
                    return const CircularProgressIndicator(
                      color: Colors.transparent,
                    );
                  },
                  future: moviesTop,
                ),
              )
            ]));
  }
}

class MovieTop {
  final int id;
  final String original_title;
  final String poster_path;
  final String overview;
  final num vote_average;

  MovieTop({
    required this.id,
    required this.original_title,
    required this.poster_path,
    required this.overview,
    required this.vote_average,
  });

  factory MovieTop.fromJson(Map<String, dynamic> json) {
    return MovieTop(
      id: json['id'],
      original_title: json['original_title'],
      poster_path: json['poster_path'],
      overview: json['overview'],
      vote_average: json['vote_average'],
    );
  }
}

Future<List<MovieTop>> fetchMoviesTop() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=861613aa2a7de68cd25a126a35966d27&language=en-US&page=1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['results'] as List;
    return topShowsJson.map((show) => MovieTop.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
