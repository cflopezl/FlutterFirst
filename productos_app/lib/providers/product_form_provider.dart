import 'package:flutter/material.dart';
import 'package:productos_app/models/model.dart';

//para conocer el estado del Form utilizamos este provider
class ProductFormProvider extends ChangeNotifier{  

  //es una referencia al widget del formulario de Product
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider( this.product );

  updateAvailabilty( bool value ){
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm(){


    return formKey.currentState?.validate() ?? false;
  }
}