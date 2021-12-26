import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () => query = ''), 
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
        return IconButton(
        icon: Icon( Icons.arrow_back ),
        onPressed: () => close(context, null)); 
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyWidget(){
    return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100,),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if( query.isEmpty ){
      return _emptyWidget();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context,listen:false);
    moviesProvider.getSuggestionByQuery(query);//esto se va a llamar cada vez que el usuario toca una tecla

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: ( _ , AsyncSnapshot<List<Movie>> snapShot){//snapShot es lo que devuelve el Future getMovieCast()
        if ( !snapShot.hasData )//esta validacion es porque al inicio por una decima de segundo el arreglo esta vacio y cuando eso suceda se muestra algo alternativo
          return _emptyWidget();

        final List<Movie> movies = snapShot.data!;//como devuelve un Future se procesa solo la informacion a utilizar

        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.symmetric( vertical: 10),
          child: ListView.builder(//carrusel
            scrollDirection: Axis.vertical,
            itemCount: movies.length,              
            itemBuilder: ( _ , int index) => _MoviePoster(movie: movies[index]),//cada elemento del ListView sera una tarjeta
          ),
        );

      }
    );   

  }
  
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster( { required this.movie } );

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${ movie.id }';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FadeInImage(
                                placeholder: AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(this.movie.fullPosterImg),
                                width: 50,
                                fit: BoxFit.contain,
                               ),
        ),
      ),
      title: Text( movie.title ),
      subtitle: Text( movie.originalTitle ),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: this.movie),
    );
  }
}

