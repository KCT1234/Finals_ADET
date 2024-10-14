import 'package:final_adet/views/login_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title: "HAU-pass",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
