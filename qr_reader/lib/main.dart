import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deepPurple = Colors.deepPurple;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        title: 'QR Reader',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': ( _ ) => HomePage(),
          'mapa': ( _ ) => MapaPage(),
        },
        theme: ThemeData(
          primaryColor: deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: deepPurple,
          ),
        ),
      ),
    );
  }
}