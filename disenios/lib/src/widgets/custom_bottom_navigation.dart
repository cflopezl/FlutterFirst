import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Color.fromRGBO(116, 117, 152, 1),
      backgroundColor: Color.fromRGBO(55, 57, 84, 1),
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined, size: 30,),
          label: "Calendario"
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart_outline_outlined, size: 30,),
          label: "Grafica"
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_outlined, size: 30,),
          label: "Usuarios"
          ),
      ]
      );
  }
}