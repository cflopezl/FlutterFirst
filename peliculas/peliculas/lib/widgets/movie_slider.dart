
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

//ya que este widget se debe redibujar, se convirtió en un StatefulWidget, 
//esto porque el scrollcontroler necesita eliminar de memoria una vez que deja de utilizarse
class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;//es lo que ejecutara "algo", en este caso invocar al provider para traer otra pagina desde home_screen

  const MovieSlider( { Key? key, required this.movies, required this.onNextPage, this.title} );

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    //implementacion de un infinite scroll
    scrollController.addListener(() {
      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Container(//Se compone de un titulo y un carrete
      width: double.infinity,//lo mas ancho posible
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,//los elementos que pertenecen a Column, inician desde la parte superior izquierda
        children: [
          if( this.widget.title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20),//separar el Text de la izquierda
              child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
            ),

          SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,              
              itemBuilder: ( _ , int index) => _MoviePoster(movie: widget.movies[index],  ) ,//cada elemento del ListView sera una tarjeta
            ),
          ),
        ],
        ),
    );

  }
}

//para evitar que la lectura del codigo sea compleja, se puede utilizar la tecnica de sacarlo 
//y volverlo un widget aca mismo, donde se utiliza 
//el guion indica que es privado
//Aca se personaliza la estructura que tendra 1 tarjeta
class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster( { Key? key, required this.movie } );

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'slider-${ movie.id }';
    return Container(//este al ser hijo define sus medidas basado en su padre, ojo da un error si el padre no lo define, ej: "widht: double.Infinity". Se resuelve envolvinedo este widget con un Expanded al tamanio del padre
                  width: 130,
                  height: 170,
                  margin: EdgeInsets.symmetric( horizontal: 10 ),
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details', arguments: this.movie),
                        child: Hero(
                          tag: movie.heroId!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder: AssetImage('assets/no-image.jpg'),
                              image: NetworkImage(this.movie.fullPosterImg),
                              width: 130,
                              height: 125,
                              fit: BoxFit.cover,
                             ),
                          ),
                        ),
                      ),
                       SizedBox(height: 5,),
                       Text( 
                         '${this.movie.originalTitle}',
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         textAlign: TextAlign.center,
                       ),

                    ],
                  ),
                );
  }
}