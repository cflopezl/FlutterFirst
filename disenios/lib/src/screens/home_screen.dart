import 'package:disenios/src/widgets/card_table.dart';
import 'package:flutter/material.dart';

import 'package:disenios/src/widgets/background.dart';
import 'package:disenios/src/widgets/page_title.dart';
import 'package:disenios/src/widgets/custom_bottom_navigation.dart';

class HomeDesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [

              //Background
              Background(),

              //Home Body
              _HomeBody(),

            ],
          ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      );
  }
}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          //Titles
          PageTitle(),

          //Cart Table
          CardTable(),
        ],
      ),
    );
  }
}