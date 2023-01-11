import 'package:flutter/material.dart';
import 'package:proyecto_1/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tercer Parcial',
      home: HomePage(),
    );
  }
}