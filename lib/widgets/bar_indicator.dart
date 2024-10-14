import 'package:flutter/material.dart';

class BarIndicator extends StatelessWidget {
  const BarIndicator({super.key});
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 40,
        height: 5,
        decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }
}