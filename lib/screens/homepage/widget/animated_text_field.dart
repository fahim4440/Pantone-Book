import 'package:flutter/material.dart';
import 'package:pantone_book/model/trendy_color_model.dart';
import 'package:pantone_book/model/week_banner_model.dart';

import '../../../widgets/circle_icon.dart';
import '../../../widgets/search_color_text_field.dart';

AnimatedBuilder animatedTextField({required Animation<double> positionAnimation, required bool isSearchActive, required double width, required FocusNode focusNode, required TextEditingController controller, required void Function() onCancel, required WeekBannerModel weekBannerModel, required String trendyText, required List<TrendyColorModel> trendyColors, required bool isDesktopMode}) {
  return AnimatedBuilder(
    animation: positionAnimation,
    builder: (context, child) {
      return Positioned(
        top: isDesktopMode ? 35 : positionAnimation.value,
        left: isDesktopMode ? positionAnimation.value : 16,
        right: isDesktopMode ? null : 16,
        child: Material(
          elevation: isSearchActive ? 8 : 0,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: isDesktopMode ? width - positionAnimation.value - 10 : width - 72,
                child: SearchColorTextField(context: context, focusNode: focusNode, controller: controller, weekBannerModel: weekBannerModel, trendyText: trendyText, trendyColorModels: trendyColors,),
              ),
              isSearchActive ? Positioned(
                right: 2,
                child: circleIcon(action: onCancel, icon: Icons.add, heroTag: 'search-cancel', angle: 3.1416/4),
              ) : SizedBox.shrink(),
            ],
          ),
        ),
      );
    },
  );
}