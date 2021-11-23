import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ta_imdb/screens/detail2.dart';

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
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Top Rated Movies',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(13, 37, 63, 1)),
                ),
              ),
              FutureBuilder(
                builder: (context, AsyncSnapshot<List<MovieTop>> snapshot) {
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
                                    builder: (context) => Detail2Page(
                                        item: snapshot.data![index].id,
                                        title: snapshot
                                            .data![index].original_title)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Center(
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.network(
                                        'https://image.tmdb.org/t/p/original' +
                                            snapshot.data![index].backdrop_path,
                                        fit: BoxFit.fill,
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        colorBlendMode: BlendMode.darken),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data![index].original_title,
                                        textAlign: TextAlign.center,
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
                                        textAlign: TextAlign.center,
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
                        );
                      },
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
              )
            ],
          ),
        ],
      ),
    );
  }
}

//API
class MovieTop {
  final int id;
  final String original_title;
  final String backdrop_path;
  final String poster_path;
  final String overview;
  final num vote_average;

  MovieTop({
    required this.id,
    required this.original_title,
    required this.backdrop_path,
    required this.poster_path,
    required this.overview,
    required this.vote_average,
  });

  factory MovieTop.fromJson(Map<String, dynamic> json) {
    return MovieTop(
      id: json['id'],
      original_title: json['original_title'],
      backdrop_path: json['backdrop_path'],
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
