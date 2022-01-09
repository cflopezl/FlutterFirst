

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static late SharedPreferences _prefs;

  static String _name = '';
  static bool _isDarkmode = false;
  static int _gender = 1;

  static Future init() async{
    _prefs  = await SharedPreferences.getInstance();
  }

  static String get name {
    //como podria ser nulo cuando no exista la propiedad en la preferencia, para ese caso mostramos el atributo _name
    return _prefs.getString('name') ?? _name;
  }

  static set name( String name ){
    _name = name;
    //grabar fisicamente en el dispositivo
    _prefs.setString('name', name);
  }

  static bool get isDarkmode {
    //como podria ser nulo cuando no exista la propiedad en la preferencia, para ese caso mostramos el atributo _name
    return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  }

  static set isDarkmode( bool isDarkmode ){
    _isDarkmode = isDarkmode;
    //grabar fisicamente en el dispositivo
    _prefs.setBool('isDarkmode', isDarkmode);
  }

  static int get gender {
    //como podria ser nulo cuando no exista la propiedad en la preferencia, para ese caso mostramos el atributo _name
    return _prefs.getInt('gender') ?? _gender;
  }

  static set gender( int gender ){
    _gender = gender;
    //grabar fisicamente en el dispositivo
    _prefs.setInt('gender', gender);
  }

}