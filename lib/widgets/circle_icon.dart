import 'package:flutter/material.dart';

Stack circleIcon(
    {required void Function() action,
    required IconData icon,
    required String heroTag,
    double angle = 0}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      const Icon(Icons.circle_sharp, size: 40, color: Colors.blueGrey,),
      const Icon(Icons.circle_sharp, size: 39, color: Colors.white,),
      IconButton(
        onPressed: action,
        icon: Hero(
          tag: heroTag,
          child: Transform.rotate(
            angle: angle,
            child: Icon(icon),
          ),
        ),
      ),
    ],
  );
}