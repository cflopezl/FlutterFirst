import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Para indicar a quien debe apuntar se especifica el provider <MoviesProvider>
    //con esto se solicita a que se vaya al arbol de widgets y que se traiga la primer instancia
    //que encuentre de MoviesProvider
    //sino encuentra una instancia va a crear una nueva, siempre y cuando se haya definido alguno
    //en AppState->MultiProvider.providers, 
    //por default esta true el listen para redibujarse
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    //print ( moviesProvider.obPopularMovies );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Películas en cines')),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined), 
            onPressed: () => showSearch( context: context, delegate: MovieSearchDelegate() ) //este metodo es global, el delegate puede ser una clase o un widget que requiere de ciertas condiciones
          )
        ],
      ),
      body: SingleChildScrollView(//permite hacer scroll sobre los elementos de Column y no tener problema con el renderizado de muchos elementos
        child: Column(
          children: [
            CardSwiper( movies: moviesProvider.obDisplayMovies ),//Tarjetas principales
            MovieSlider( 
              movies: moviesProvider.obPopularMovies, 
              title:"Populares!",
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),//Listado horizontal de películas
          ],
        ),
      )
    );
  }
}