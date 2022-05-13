import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testforegroup/providers/movie_provider.dart';
import 'package:testforegroup/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/movie.dart';

const String boxName = 'favourite_list';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  await Hive.initFlutter();
  var directory = await getApplicationDocumentsDirectory();;
  Hive..init(directory.path)..registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>(boxName);

  runApp(const AppSatate());
}

class AppSatate extends StatelessWidget {
  const AppSatate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: getAplicationRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
