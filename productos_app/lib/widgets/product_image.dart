import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10, right: 10, top:10),
      child: Container(
        decoration: _boxDecoration(),
        width: double.infinity,
        height: 450,
        child:  Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() => const BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 5),
      )
     ]
  );

  Widget getImage( String? picture ){
    if ( picture == null ){
      return Image(image: AssetImage('assets/no-image.png'),fit: BoxFit.cover,);
    }

    if( picture.startsWith('http')){       
      return FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'), 
              image: NetworkImage(this.url!),
              fit: BoxFit.cover);
    }

    return Image.file(
      File( picture ),
      fit: BoxFit.cover,
    );

  }
}