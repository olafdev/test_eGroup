import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:testforegroup/helpers/debouncer.dart';
import 'package:testforegroup/models/models.dart';
import 'package:testforegroup/models/search_response.dart';

class MovieProvider extends ChangeNotifier {

  // !Put your API_KEY here.
  final String _apiKey = 'a85777584e4736db59dcebd7a17106b6';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> popularMovies = [];

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MovieProvider() {
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, '3/movie/$endPoint', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await
    _getJsonData('popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
