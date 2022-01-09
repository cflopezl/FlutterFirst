import 'package:flutter/material.dart';
import 'package:preferences_app/screens/screens.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Drawer se utiliza para mostrar un menu de hamburguesa
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,//para que el contenido inicie desde la parte mas alta sin importarle el notch
        children: [
          
          const _DrawerHeader(),

          ListTile(
            leading: const Icon(Icons.pages_outlined),
            title: const Text('Home'),
            onTap: () { 
              Navigator.pushReplacementNamed(context, HomeScreen.routerName);
            }),

          ListTile(
            leading: const Icon(Icons.people_outlined),
            title: const Text('People'),
            onTap: () { 
              Navigator.pushNamed(context, SettingScreen.routerName);
            }),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () { 
              // Navigator.pop(context);//cuando presiona regresar se muestra correctamente el Home y no el Menu lateral
              //otra forma es cambiando pushNamed x pushReplacementNamed
              Navigator.pushReplacementNamed(context, SettingScreen.routerName);
            }),

        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu-img.jpg'),
          fit: BoxFit.cover,//para que la imagen tome todo el espacio
        )
      ),
    );
  }
}