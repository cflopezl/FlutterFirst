import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/mapa_page.dart';

import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/pages/mapas_history_page.dart';
import 'package:qr_reader/pages/direcciones_page.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //AppBar
        appBar: AppBar(
          elevation: 0,
          title: Text('Historial'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: (){ 
                //en este widget no se va a redibujar
                final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.borrarTodos(); 
                }
            ), 
          ]
        ),

        //Body
        body: _HomePageBody(),
        
        //Floating Button
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
        //Bottom Navigation
        bottomNavigationBar: CustomNavigationBar(),

      );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // TODO: temporal
    //DBProvider.db.database;
    final tempScan = new ScanModel(valor: 'http://google.com');
    //DBProvider.db.nuevoScan(tempScan);       
    //DBProvider.db.getScanById(15).then((value) => print(value));
    //DBProvider.db.getAllScan().then((value) => print(value));
    //DBProvider.db.getScanByTipo('http').then((value) => print(value));
    //DBProvider.db.deleteAllScan().then((value) => print(value));


    // Cambiar para mostrar la pagina que corresponda
    switch(currentIndex){

      case 0: 
        return MapasHistoryPage();

      case 1:
        return DireccionesPage();

      default: 
        return MapasHistoryPage();
    }
  }

}