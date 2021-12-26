import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards( this.movieId );

  @override
  Widget build(BuildContext context) {
    
    //Para indicar a quien debe apuntar se especifica el provider <MoviesProvider>
    //con esto se solicita a que se vaya al arbol de widgets y que se traiga la primer instancia que encuentre de MoviesProvider
    //sino encuentra una instancia va a crear una nueva, siempre y cuando se haya definido alguno
    //en AppState->MultiProvider.providers, se pone en false el listen porque donde se va a invocar es en un metodo y eso no se va a redibujar
    final moviesProvider = Provider.of<MoviesProvider>(context,listen:false);

    //el future a lanzar es el que tenemos en el provider MoviesProvider->getMovieCast()
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapShot){//snapShot es lo que devuelve el Future getMovieCast()
        if ( !snapShot.hasData )//esta validacion es porque al inicio por una decima de segundo el arreglo esta vacio y cuando eso suceda se muestra algo alternativo
          return Container(            
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );

        final List<Cast> cast = snapShot.data!;//como devuelve un Future se procesa solo la informacion a utilizar

        return Container(
          width: double.infinity,
          height: 180,
          child: ListView.builder(//carrusel
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,              
            itemBuilder: ( _ , int index) => _CastCard(actor: cast[index]),//cada elemento del ListView sera una tarjeta
          ),
        );

      }
    );    
  }
}

class _CastCard extends StatelessWidget {  
  
  final Cast actor;
  const _CastCard( {required this.actor} );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 110,
      height: 180,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage('${this.actor.fullProfilePath}'),
            width: 140,
            height: 135,
            fit: BoxFit.cover,
          ),
        ),
        
        SizedBox(height: 5,),

        Text(
          '${this.actor.name}',
          maxLines:2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],),
    );
  }
}