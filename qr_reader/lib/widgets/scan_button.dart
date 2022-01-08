import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async{

        /*String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                    '#3D8BEF', 
                                                    'Cancelar', 
                                                    false, 
                                                    ScanMode.QR);*/
        // TODO borrar
        String barcodeScanRes='geo:14.670357282668862,-90.46641059400899';
        //barcodeScanRes='http://minfin.gob.gt';
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final scan = await scanListProvider.nuevoScan( barcodeScanRes );

        launchURL(context, scan);
        
        //print(barcodeScanRes);
                                                    
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}