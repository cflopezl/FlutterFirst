import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas/models/models.dart';

class CardSwiper extends StatelessWidget {
    final List<Movie> movies;
   
    const CardSwiper( { Key? key, required this.movies } );
    
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    //sirve para quitar el error en debug console, 
    //ya que cuando en un momento no tienen ninguna pelicula que renderizar
    //esta intentando hacerlo
    if( this.movies.length==0 )
      return Container(
        width: double.infinity,
        height: size.height*0.6,
        child: Center(child: CircularProgressIndicator(),),//Se parece a un gif que esta esperando a cargar
      );

    return Container(
      width: double.infinity,
      height: size.height*0.6,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.5,
        itemBuilder: (BuildContext context, int index){
          final movie = movies[index];
          movie.heroId = 'swiper-${ movie.id }';
          return GestureDetector(//permite navegar a otros widgets, en este ejemplo a la ruta 'details'
            onTap: () => Navigator.pushNamed(context, 'details', arguments:movies[index]),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(//permite añadir un border radius a las tarjetas del FadeInImage
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(movie.fullPosterImg),
                      fit: BoxFit.cover,//adaptar la imagen al tamño del contenedor padre
                    )
              ),
            )
          );

        },
      )
    );
  }
}