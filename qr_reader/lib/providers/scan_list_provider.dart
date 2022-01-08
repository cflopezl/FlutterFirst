import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  //Datos que forman parte del estado de este Provider
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan( String valor ) async{

    final nuevoScan = new ScanModel(valor: valor);
    final respuesta = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = respuesta;

    if( this.tipoSeleccionado == nuevoScan.tipo ){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    
    return nuevoScan;
  }

  cargarScans() async{

    final scans = await DBProvider.db.getAllScan();
    this.scans = [ ...scans ];
    notifyListeners();

  }

  cargarScansPorTipo( String tipo ) async{

    final scans = await DBProvider.db.getScanByTipo(tipo);
    this.scans = [ ...scans ];
    this.tipoSeleccionado = tipo;
    notifyListeners();

  }

  borrarTodos() async{
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }


  borrarScanPorId( int id ) async{
    /*
    la vista de usuario es la parte mas importante ya que funciona en el hilo
    principal de toda aplicación, por tal motivo no puede esperar ese 0.3 seg que tarda en hacer un delete del Future, 
    tiene que brindar informacion al usuario de manera continua.
    En este caso cuando borramos el scan estamos pidiendo al ui que espere hasta que se borre los datos de la base de datos 
    y asi brindar informacion actualizada, cosa que no es posible. 
    Para arreglar este problema les recomeindo borrar primero el registro del arreglo scans del provider
    */
    scans.removeWhere((element) => element.id == id );
    await DBProvider.db.deleteScan(id);
    this.cargarScansPorTipo( this.tipoSeleccionado );

  }



}