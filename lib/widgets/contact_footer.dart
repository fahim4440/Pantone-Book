import 'package:flutter/material.dart';
import '../repository/image_repository.dart';

SizedBox ContactFooter() {
  ImageRepository imageRepository = ImageRepository();
  return SizedBox(
    height: 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Need any help? Contact:',
          style: TextStyle(
            fontSize: 8.0,
            color: Colors.blueGrey[80],
          ),
        ),
        const SizedBox(width: 10.0,),
        InkWell(
          onTap: imageRepository.launchEmail,
          child: Image.asset("assets/gmail.png", height: 15.0, width: 15.0,),
        ),
        const SizedBox(width: 10.0,),
        InkWell(
          onTap: imageRepository.launchLinkedIn,
          child: Image.asset("assets/linkedin.png", height: 15.0, width: 15.0,),
        ),
        const SizedBox(width: 10.0,),
        InkWell(
          onTap: imageRepository.launchFacebook,
          child: Image.asset("assets/facebook.png", height: 15.0, width: 15.0,),
        ),
      ],
    ),
  );
}