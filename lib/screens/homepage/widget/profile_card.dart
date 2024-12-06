import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../widgets/circle_icon.dart';

Card profileCard({required void Function() action, required String name,}) {
  return Card(
    margin: const EdgeInsets.all(10.0),
    color: Colors.cyan[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5.0,
    child: InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circleIcon(action: action, icon: Icons.person, heroTag: 'profile-pic'),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello, ${name.split(" ").first}", style: const TextStyle(fontWeight: FontWeight.bold),),
                Text("${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('ddMMM').format(DateTime.now())}", style: const TextStyle(fontSize: 10),),
              ],
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    ),
  );
}