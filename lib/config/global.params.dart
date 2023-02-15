import 'package:flutter/material.dart';

import '../notifier/MonTheme.dart';
class GlobalParams{
  static MonTheme themeActuel=MonTheme();
  static List<Map<String,dynamic>>menus=[
    {"title":"Accueil","icon":Icon(Icons.home,color:Colors.blue),"route":"/home"},
    {"title":"Meteo","icon":Icon(Icons.sunny_snowing,color:Colors.blue),"route":"/meteo"},
    {"title":"Gallerie","icon":Icon(Icons.home,color:Colors.blue),"route":"/gallerie"},
    {"title":"Pays","icon":Icon(Icons.home,color:Colors.blue),"route":"/pays"},
    {"title":"Conatact","icon":Icon(Icons.home,color:Colors.blue),"route":"/contact"},
    {"title":"Parametres","icon":Icon(Icons.home,color:Colors.blue),"route":"/parametres"},
    {"title":"Deconnexion","icon":Icon(Icons.home,color:Colors.blue),"route":"/authentification"},
  ];
}