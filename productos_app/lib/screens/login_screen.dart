import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const route = "login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AuthBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 
                 SizedBox(
                   height: 250,
                 ),
                 
                 CardContainer(
                   child: Column(
                     children: [
                       SizedBox(height: 10,),

                       Text('Login',style: Theme.of(context).textTheme.headline4,),

                       SizedBox(height: 30,),
                      
                      ChangeNotifierProvider(
                        create: ( _ ) => LoginFormProvider(),
                        child: _LoginForm(),//crea una instancia de login form provider y redibujar los widgtet cuando sea necesario y solo loginform tendra acceso a loginformprovider
                      )
                       
                     ],
                   ),
                 ),

                 SizedBox(height: 50,),

                 Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(//tendra una referencia al estado completo que tienen sus widgets internos
        //mantener la referencia al KEY para mantener el estado del formulario

        key: loginForm.formKey,

        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'ex john.doe@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded
              ) ,
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El correo ingresado no cumple con su formato';
              },
            ),

            SizedBox(height: 30,),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '****',
                labelText: 'Contrasena',
                prefixIcon: Icons.lock_outline
              ) ,
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ){
                
                if( value != null && value.length>=6 ) return null;

                return 'La contrasenia debe tener minimo 6 caracteres';
              },
            ),

            SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Container(
                child: Text(
                  loginForm.isLoading 
                  ? 'Espere'
                  : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),   
              ),
              onPressed: loginForm.isLoading ? null : () async {//al colocar null se desactiva el boton
                
                FocusScope.of(context).unfocus();

                //asociado a las validation definidas en los textbox para que se ejecuten
                if( !loginForm.isValidForm() ) return;
                
                loginForm.isLoading = true;

                await Future.delayed(Duration(seconds: 2));

                loginForm.isLoading=false;

                //pushReplacementNamed destruye el stack de las pantallas para dejar unicamente las pantallas
                Navigator.pushReplacementNamed(context, HomeScreen.route);
              },
              ),


          ],
        )
      ),
    );
  }
}