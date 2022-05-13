import 'package:flutter/material.dart';
import 'package:testforegroup/providers/movie_provider.dart';
import 'package:testforegroup/search/movie_search_delegate.dart';
import 'package:testforegroup/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App for eGroup'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoriteScreen.routeName, arguments: null);
            },
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Popular Movies',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
