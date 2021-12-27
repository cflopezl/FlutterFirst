import 'package:disenios/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:disenios/src/screens/scroll_design.dart';
import 'package:disenios/src/screens/basic_design.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home_design',
      theme: ThemeData.dark(),
      routes: {
        'basic_design':( _ ) => BasicDesignScreen(),
        'scroll_design':( _ ) => ScrollDesignScreen(),
        'home_design':( _ ) => HomeDesignScreen(),
      },      
    );
  }
}