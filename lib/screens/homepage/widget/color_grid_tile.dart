import 'package:flutter/material.dart';
import 'package:pantone_book/model/pantone_model.dart';

Card colorGridTile({required void Function() action, required PantoneColor color,}) {
  return Card(
    elevation: 5,
    color: Color.fromARGB(255, color.red, color.green, color.blue),
    child: InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          color.pantoneCode == "" ? const SizedBox() : SelectableText(color.pantoneCode, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          SelectableText(color.colorName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          SizedBox(height: 10,),
        ],
      ),
    ),
  );
}