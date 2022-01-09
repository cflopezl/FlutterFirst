import 'package:flutter/material.dart';
import 'package:preferences_app/providers/theme_provider.dart';
import 'package:preferences_app/screens/screens.dart';
import 'package:preferences_app/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

void main() async{
  //inicializar las preferencias colocando el main async e invocar a init
  //para mantener el acceso al componente desde cualquier parte de la aplicacion
  //esta primer linea es para quitar un error
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    //otra forma de tener un provider de forma general 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) 
                        => ThemeProvider(isDarkMode: Preferences.isDarkmode)
        )
      ],
      child: const MyApp(),
    )
    
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName: ( _ ) => const HomeScreen(),
        SettingScreen.routerName: ( _ ) => const SettingScreen()
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,//para que cambie cuando ocurre un cambio en el estado
    );
  }
}