import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    final vCurrentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) { uiProvider.selectedMenuOpt = i; },
      elevation: 0,
      currentIndex: vCurrentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones',
          ),
      ]
    );
  }
}