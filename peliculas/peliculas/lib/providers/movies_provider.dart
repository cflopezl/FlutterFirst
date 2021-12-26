import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{
  String _apiKey = 'deaa43e4c2ec9368eaa9d1004dc8dc3d';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es/ES';

  List<Movie> obDisplayMovies = [];
  List<Movie> obPopularMovies = [];
  Map<int, List<Cast>> obMoviesCast = {};
  
  int _popularPage = 0;

  final debouncer = Debouncer(
                      duration: Duration(
                                  milliseconds: 500,
                                  )
                    );
  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider(){
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page=1] ) async{//page es opcional
    final url =
      Uri.https(_baseUrl, endpoint, 
                  {
                    'api_key': _apiKey,
                    'language': _language,
                    'page': '$page',
                  }
                );

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{    
    final jsonData = await _getJsonData('3/movie/now_playing');
    //convertir la respesta en un mapa
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    obDisplayMovies = nowPlayingResponse.results;
    //se le notifica a todos los listeners, es decir, todos los widgets que esten escuchando
    //que se vuelvan a renderizar porque ha ocurrido un cambio
    notifyListeners();

  }

  getPopularMovies() async{
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    //convertir la respesta en un mapa
    final popularResponse = PopularResponse.fromJson(jsonData);
    obPopularMovies = [...obPopularMovies, ...popularResponse.results];
    //se le notifica a todos los listeners, es decir, todos los widgets que esten escuchando
    //que se vuelvan a renderizar porque ha ocurrido un cambio
    notifyListeners();
  }

  //con el hecho de ser async el metodo se esta indicando que devuelve un Future
  //=> configuramos el metodo para retornar el future que correctamente se devolvera  
  Future<List<Cast>> getMovieCast( int movieId ) async{
    if( obMoviesCast.containsKey(movieId) )
      return obMoviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResonse = new CreditsResponse.fromJson(jsonData);

    obMoviesCast[movieId] = creditsResonse.cast;
    return creditsResonse.cast;
    
  }

    //con el hecho de ser async el metodo se esta indicando que devuelve un Future
  //=> configuramos el metodo para retornar el future que correctamente se devolvera  
  Future<List<Movie>> getMovieSearch( String query ) async{   

    final url =
      Uri.https(_baseUrl, '3/search/movie', 
                  {
                    'api_key': _apiKey,
                    'language': _language,
                    'page': '1',
                    'query': query,
                  }
                );

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    final findMovieResponse = new FindMovieResponse.fromJson(response.body);

    return findMovieResponse.results;
    
  }

  void getSuggestionByQuery( String searchTerm ){
    debouncer.value = '';
    //metodo a llamar cuando pasen las 500 milesimas de segundo configuradas    
    debouncer.onValue = ( value ) async {
      final results = await getMovieSearch(value);
      this._suggestionStreamController.add(results);
    };


    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      //cada vez que pasen 300 milliseconds se va a ejecutar lo siguiente
      debouncer.value = searchTerm;
    });

    //esto se ejecutara cuando se cancele una busqueda
    Future.delayed(Duration(milliseconds: 301)).then(( _ ) => timer.cancel() );

  }

}