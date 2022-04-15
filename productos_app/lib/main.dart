import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => ProductService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
       initialRoute: LoginScreen.route,//se debe rediccionar al login para que se vuelva a generar otro token correctamente generado
      routes: {
        CheckAuthScreen.route : ( _ ) => CheckAuthScreen(),

        LoginScreen.route : ( _ ) => const LoginScreen(),
        RegisterScreen.route : ( _ ) => const RegisterScreen(),
        
        HomeScreen.route : ( _ ) => const HomeScreen(),
        ProductScreen.route : ( _ ) => const ProductScreen(),
      },
      //al hacer esto, en cualquier parte de la aplicacion utilizado los metodos static
      //tenemos acceso a este Scaffold, usado para el SnackBar (Alert message)
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
          
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Colors.indigo,
        )
      ),
    );
  }
}