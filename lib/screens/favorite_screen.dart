import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/movie.dart';
import '../widgets/fav_movie_slider.dart';

const String boxName = 'favourite_list';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  static const String routeName = 'Favorite';

  @override
  Widget build(BuildContext context) {
    late Box<Movie> box = Hive.box<Movie>(boxName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.green, //change your color here
        ),
        title: const Text("Favorite", style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FavoriteMovieSlider(
              movies: box.values.toList(),
              title: 'Your Favorite Movies',
              onNextPage: () => box.values.toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
