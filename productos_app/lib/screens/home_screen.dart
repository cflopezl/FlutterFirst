import 'package:flutter/material.dart';
import 'package:productos_app/models/model.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const route = "home";
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    //Esto funciona porque cuando cambia la variable isLoading el NotifierListener 
    //implementado en el loadProducts le dice a este widget que se redibuje, es decir,
    //que se vuelva a cargar tanto cuando esta en false como cuando esta en true 
    if( productsService.isLoading ) return LoadingScreen();

    //la ventaja de utilizar ListViewBuilder a diferencia de ListView es que va a entrar en modo perezoso
    //es que va a crear los widgets cuando este cerca de entrar a la pantalla, no los va a mantener a todos
    //activos, bastante util cuando se tienen muchos
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          icon: Icon( Icons.login_outlined ),
          onPressed: () {

            authService.logout();
            Navigator.pushReplacementNamed(context, LoginScreen.route);
            
          }, 
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( BuildContext context, int index ) => GestureDetector(
          onTap: () { 
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, ProductScreen.route); 
          },
          child: ProductCard(product:productsService.products[index])
          )
      ), 
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add ),
        onPressed: () {

          productsService.selectedProduct = Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, ProductScreen.route);

        },
      ),
    );
  }
}