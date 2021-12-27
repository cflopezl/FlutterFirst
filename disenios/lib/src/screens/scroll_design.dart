import 'package:flutter/material.dart';

class ScrollDesignScreen extends StatelessWidget {
  final boxDecoration = BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.5,0.5,
              ],
              colors: [
                Color(0xff5EE8C5),
                Color(0xff30BAD6),
              ]
              )
          );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff30BAD6),
        body: Container(
          decoration: boxDecoration,
          child: PageView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Page1(),
              Page2()
            ],
          ),
        ),
      );
  }
}

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Background image
        Background(),
        //Contenido principal
        MainContent()
      ],
    );
  }
}

class Background extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff30BAD6),
      height: double.infinity,
      alignment: Alignment.topCenter,
      child: Image(image: AssetImage('assets/scroll-1.png'))
    );
  }
}

class MainContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold);
    return SafeArea(//protege la parte superior del widget
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('11º', style: textStyle,),
          Text('Miercoles', style: textStyle,),
          Expanded(child: Container( )),
          Icon( Icons.keyboard_arrow_down, size: 100, color: Colors.white,)
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff30BAD6),
      child: Center(
        child: TextButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            child: Text('Bienvenido', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))
            ),
          onPressed: (){},          
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff0098FA),
            shape: StadiumBorder()
          ),
          ),
        ),
    );
  }
}