import 'package:flutter/material.dart';

import '../../../model/week_banner_model.dart';

Stack weekBanner({required void Function() action, required double screenWidth, required WeekBannerModel weekBannerModel}) {
  Color bannerColor = Color.fromARGB(255, weekBannerModel.bannerColorR, weekBannerModel.bannerColorG, weekBannerModel.bannerColorB);
  Color bannerFontColor = Color.fromARGB(255, weekBannerModel.bannerFontColorR, weekBannerModel.bannerFontColorG, weekBannerModel.bannerFontColorB);
  Color tcxFontColor = Color.fromARGB(255, weekBannerModel.tcxFontColorR, weekBannerModel.tcxFontColorG, weekBannerModel.tcxFontColorB);
  Color tcxColor = Color.fromARGB(255, weekBannerModel.tcxColorR, weekBannerModel.tcxColorG, weekBannerModel.tcxColorB);
  return Stack(
    children: [
      Container(
        width: screenWidth,
        height: 150,
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: bannerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: action,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color of the", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: bannerFontColor),),
                      Text("WEEK", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: bannerFontColor),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        right: 50,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 5,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                width: screenWidth * 0.30,
                height: 150,
                color: Colors.black87,
              ),
              Container(
                width: screenWidth * 0.30 - 1,
                height: 149,
                color: Colors.white,
              ),
              Container(
                width: screenWidth * 0.30 -2,
                height: 148,
                color: Colors.black87,
              ),
              Hero(
                tag: 'color-of-the-week',
                child: Container(
                  width: screenWidth * 0.30 -3,
                  height: 147,
                  color: tcxColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(weekBannerModel.colorName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: tcxFontColor),),
                      Text(weekBannerModel.tcxCode, style: TextStyle(fontSize: 9, color: tcxFontColor,),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}