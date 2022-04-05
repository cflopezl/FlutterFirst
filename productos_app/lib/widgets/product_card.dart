import 'package:flutter/material.dart';
import 'package:productos_app/models/model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard( { Key? key, required this.product } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    //Este widget es el que representa cada producto que sera colocado en el ListView.builder
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _BackgroundImage(product.picture),

            _ProductDetails(product:product),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(product.price)
            ),

            //Mostrar de forma condicional
            if( !product.available )
              Positioned(//ubicacion dentro de la tarjeta
                top: 0,
                left: 0,
                child: _NotAvailable()
              ),


          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 6),
      )
    ],
  );
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const  EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
      alignment: Alignment.center,
      child: const FittedBox(//con este widget el texto se adapta al espacio que tiene disponible
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:  Text('No Disponible', style: TextStyle(color: Colors.black, fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const  EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
      alignment: Alignment.center,
      child: FittedBox(//con este widget el texto se adapta al espacio que tiene disponible
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:  Text('\$$price', style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final Product product;

  const _ProductDetails( { Key? key, required this.product } );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( right: 50 ),
      child: Container(
        padding: const  EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, 
            style: const TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold ),
            maxLines: 1,
            overflow: TextOverflow.fade,
            ),

            Text(product.id!, 
            style: const TextStyle( fontSize: 15, color: Colors.white,),
            ),
            
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration( ) => const BoxDecoration(    
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),
  );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage( this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null ? Image(image: AssetImage('assets/no-image.png'),fit: BoxFit.cover,) 
        : FadeInImage( 
          placeholder: AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(url!),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}