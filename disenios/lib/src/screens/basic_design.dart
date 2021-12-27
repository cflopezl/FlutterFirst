import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Imagen
          Image(image: AssetImage('assets/landscape.jpg'),),
          
          //Titulo
          Title(),

          //Botonera
          Buttons(),

          Container(
            margin: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
            child: Text('Lorem dolore tempor et sint irure dolor ad sit. Culpa esse adipisicing incididunt reprehenderit. Et fugiat eiusmod proident dolor eu in duis et elit. Reprehenderit labore nulla elit cupidatat laboris veniam pariatur amet veniam irure. Laboris veniam anim anim sint incididunt velit commodo sint mollit consequat incididunt eu dolore esse. Commodo est incididunt exercitation cillum dolor deserunt id magna. Lorem aute et elit anim dolore eiusmod veniam velit. Pariatur ea non sint sit magna laborum ullamco aliquip consequat commodo reprehenderit. Veniam incididunt consequat ipsum mollit. Quis quis laboris veniam aute anim veniam occaecat cillum ut magna culpa reprehenderit. Sunt amet occaecat ullamco ipsum in. Aliquip mollit minim velit non adipisicing exercitation Lorem est reprehenderit adipisicing occaecat.')
            )
        ],
      )
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 40, vertical: 20 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[ 
              Text('Oeschinen Lake Campground', style: TextStyle( fontWeight: FontWeight.bold ),),
              SizedBox(height: 7,),
              Text('Kandersteg, Switzerland', style: TextStyle( color: Colors.black45 ),)
            ]),
          Expanded(child: Container()),
          Icon(Icons.star, color: Colors.red,),
          Text('41'),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 80, vertical: 20 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBottom(icon:Icons.phone, text: 'CALL',),
          CustomBottom(icon:Icons.gps_fixed, text: 'ROUTE',),
          CustomBottom(icon:Icons.share, text: 'SHARE',),                 
        ],
      ),
    );
  }
}

class CustomBottom extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomBottom({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        Icon(this.icon, color: Colors.lightBlue,size: 30,),
        SizedBox(height: 10,),
        Text(this.text , style: TextStyle( color: Colors.lightBlue ),)
        ],
    );
  }
}

