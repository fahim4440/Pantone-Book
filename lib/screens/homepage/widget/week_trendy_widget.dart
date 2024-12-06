import 'package:flutter/material.dart';
import 'package:pantone_book/model/trendy_color_model.dart';
import 'package:pantone_book/model/week_banner_model.dart';
import 'package:pantone_book/screens/homepage/widget/trendy_color_slideshow.dart';
import 'package:pantone_book/screens/homepage/widget/week_banner.dart';

Row weekTrendyWidget({required double width, required WeekBannerModel weekBannerModel, required String trendyText, required List<TrendyColorModel> trendyColorModels}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      weekBanner(action: () {
        // Navigator.push(context, FadeAnimatedPageRoute(page: const ColorOfTheWeekPage()));
      }, screenWidth: width / 2 - 20, weekBannerModel: weekBannerModel),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 5),
                child: Text(trendyText),
              ),
              Icon(Icons.arrow_forward_ios, size: 10, color: Colors.blueGrey,)
            ],
          ),
          TrendyColorSlideshow(trendyColorModels: trendyColorModels, width: width / 2 - 20,),
        ],
      ),
    ],
  );
}