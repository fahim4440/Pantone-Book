import 'package:flutter/material.dart';

Card backButton({required void Function() action}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
          child: Icon(Icons.arrow_back_ios,),
        ),
      ),
    ),
  );
}