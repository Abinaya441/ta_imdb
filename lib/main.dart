import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ta_imdb/screens/splash.dart';
import 'package:ta_imdb/screens/home.dart';
import 'package:ta_imdb/screens/list1.dart';
import 'package:ta_imdb/screens/list2.dart';
import 'package:ta_imdb/screens/profile.dart';
import 'package:ta_imdb/screens/detail1.dart';
import 'package:ta_imdb/screens/detail2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const IMDbApp());
}

class IMDbApp extends StatelessWidget {
  const IMDbApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light)),
      title: 'IMDb',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/list1': (context) => const List1Page(),
        '/list2': (context) => const List2Page(),
        '/profile': (context) => const ProfilePage(),
        '/detail1': (context) => const Detail1Page(item: 0, title: ''),
        '/detail2': (context) => const Detail2Page(item: 0, title: '')
      },
    );
  }
}
