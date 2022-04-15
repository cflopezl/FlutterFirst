import 'package:flutter/material.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:productos_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/services/services.dart';

class CheckAuthScreen extends StatelessWidget {

  static const route = "checking";

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>( context, listen:false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if( !snapshot.hasData )
              return Text('Espere');
            
            if( snapshot.data == '' ){

              Future.microtask(() { 
                //Navigator.of(context).pushReplacementNamed(HomeScreen.route);
                //se cambia para tener una transicion mas natural
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: ( _ , __ , ___) => LoginScreen(),
                  transitionDuration: Duration( seconds: 0 ),
                  ));
              });

            }else{
                Future.microtask(() { 
                //Navigator.of(context).pushReplacementNamed(HomeScreen.route);
                //se cambia para tener una transicion mas natural
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: ( _ , __ , ___) => HomeScreen(),
                  transitionDuration: Duration( seconds: 0 ),
                  ));
              });
            }
            
            //es la instruccion que se va a ejecutar cuando el widget se termine de pintar
            
            return Container();
          }
        ), 
      ),
    );
  }
}