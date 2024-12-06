import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantone_book/bloc/homepage/homepage_bloc.dart';
import 'package:pantone_book/model/trendy_color_model.dart';
import 'package:pantone_book/model/week_banner_model.dart';
import '../bloc/search_color/color_search_bloc.dart';

TextField SearchColorTextField(
    {required BuildContext context,
    WeekBannerModel? weekBannerModel,
    List<TrendyColorModel>? trendyColorModels, String? trendyText, FocusNode? focusNode, TextEditingController? controller}) {
  return TextField(
    onChanged: weekBannerModel != null ? (String query) {
      BlocProvider.of<HomepageBloc>(context).add(
          HomepageSearchTriggerEvent(query: query, weekBannerModel: weekBannerModel, trendyColorModels: trendyColorModels!, trendyText: trendyText!));
    } : null,
    focusNode: focusNode,
    controller: controller,
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 6.0),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      focusColor: Colors.blueGrey,
      labelText: "Search Pantone",
      labelStyle: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}