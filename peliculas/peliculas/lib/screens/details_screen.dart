import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  // Sirve para recoger los argumentos que son trasladados al Widget desde la navegacion
  final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(//este widget funciona al darle scroll dando un comportamiento diferente(bonito)
        slivers: [
          _CustomAppBar(movie: movie,),//appbar customizado de tipo sliver para que no de error
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie,),
              _Overview(movie: movie,),
              _Overview(movie: movie,),
              _Overview(movie: movie,),
              CastingCards( movie.id ),
            ])
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {  
  final Movie movie;
  const _CustomAppBar({ required this.movie });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(//
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only( bottom: 10, left: 10, right: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(//imagen de fondo en el AppBar
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage('${this.movie.fullBackdropPath}'),
          fit: BoxFit.cover //para que se expanda todo lo que pueda, sin perder las dimensiones de la imagen
        ),
      ),
      
    );
  }

}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({ required this.movie });
  
  @override
  Widget build(BuildContext context) {
    
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only( top: 20 ),
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(//sera Row porque agregaremos elementos uno al lado del otro
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('${this.movie.fullPosterImg}'),
                height: 150,
              )
            ),
          ),

          SizedBox(width: 20,),

          ConstrainedBox(
            constraints: BoxConstraints (maxWidth: size.width - 190 ),
            child: Column(//titulo de pelicula, titulo original y otros datos como una columna
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title, style: textTheme.headline5,overflow: TextOverflow.ellipsis, maxLines:2 ),
                Text( movie.originalTitle, style: textTheme.subtitle1,overflow: TextOverflow.ellipsis, maxLines:2 ),
                Row(children: [
                  Icon( Icons.star_outline, size: 15, color: Colors.grey,),
                  SizedBox(width:5),
                  Text( movie.voteAverage.toString(), style: textTheme.caption, ),
                ],)
              ]
            ),
          )
        ],
      )
    );
  }
}



class _Overview extends StatelessWidget {  
  final Movie movie;
  const _Overview({ required this.movie });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: Text(movie.overview, style: textTheme.caption, textAlign: TextAlign.justify,),
    );
  }
}