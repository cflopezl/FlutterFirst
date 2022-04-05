import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/models/model.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const route = "product";
  const ProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    
    //se hizo un widget del boty, donde se crea una instancia de ProductFormProvider
    //enviandole el producto seleccionado al darle tap en la lista de productos de HomeScreen
    //como la camara se encuentra afuera del form fue necesario hacer esto para tener acceso al provider
    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider( productService.selectedProduct ),
      child: _ProductScreenBody(productsService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductService productsService;

  @override
  Widget build(BuildContext context) {
    
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView ( //este widget es muy util en los casos donde se tenga que hacer scroll
        //con esta propiedad se puede ocultar el teclado cuando se realiza scroll, 
        //pero puede ser muy agresiva la funcionalidad porque en ocasiones el usuario hace scroll 
        //para ver informacion y no quiere quitar el teclado
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            _Top( productService: productsService ),

            _ProductForm(),

            const SizedBox( height: 100,),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productsService.isSaving 
        ? CircularProgressIndicator( color: Colors.white, )
        : Icon(Icons.save_outlined),
        onPressed: productsService.isSaving 
        ? null //para que no pueda hacer clic en el boton
        : () async{
          if( !productForm.isValidForm() ) return;

          final String? imageUrl = await productsService.uploadImage();

          if( imageUrl != null ) productForm.product.picture = imageUrl;

          productsService.saverOrCreate(productForm.product);

        }
      ),

    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _boxDecoration(),
        child: Form(
          //es la forma de asociar a un Formulario con su Form Provider
          //y ya se puede validar el formulario con la logica del provider 
          //al momento de presionar el boton grabar
          key: productForm.formKey,
          //validar el formulario en base a la reglas definidas por cada interaccion del usuario
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if( value==null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del Producto', 
                  labelText: 'Nombre:'
                ),
              ),
              SizedBox(height: 30,),
              
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if( double.tryParse(value) == null )
                    product.price = 0;
                  else
                    product.price = double.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', 
                  labelText: 'Precio:'
                ),
              ),
              SizedBox(height: 30,),

              SwitchListTile(
                value: product.available, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) => productForm.updateAvailabilty(value)
              ),

              SizedBox(height: 30,),
            ],
          )
          ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only( bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5
          )
        ]
      );
  }
}

class _Top extends StatelessWidget {

  final ProductService? productService;

  const _Top({Key? key, this.productService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

         ProductImage(url:productService!.selectedProduct.picture),
          
         Positioned(
           top: 60,
           left: 20,
           child: IconButton(
             onPressed: () => Navigator.of(context).pop(),
             icon: const Icon(
               Icons.arrow_back_ios_new,
               size: 40,
               color: Colors.grey,
              ),
           ),
        ),

        Positioned(
           top: 60,
           right: 20,
           child: IconButton(
             onPressed: () async {
               
               final picker = new ImagePicker();
               final PickedFile? pickedFile = await picker.getImage(
                 source: ImageSource.gallery,
                 imageQuality: 100
                 );

                if( pickedFile == null ){
                  print('no selecciono nada');
                  return;
                }

                //print( 'tenemos imagen ${ pickedFile.path }');
                productService!.updatedSelectedProductImage(pickedFile.path);

             },
             icon: const Icon(
               Icons.camera_alt_outlined,
               size: 40,
               color: Colors.grey,
              ),
           ),
        )


      ],
    );
  }
}