import 'package:pantone_book/services/pantone_database/app_db.dart';

import '../../model/trendy_color_model.dart';
import '../../model/week_banner_model.dart';

class HomepageDbHelper {
  //Week Banner DB

  Future<void> insertWeekBanner(WeekBannerModel banner) async {
    final db = AppDb.instance;
    // final db = database;
    await db.insertWeekBanner(banner);
  }

  Future<void> clearWeekBannerTable() async {
    final db = AppDb.instance;
    // final db = await database;
    await db.clearWeekBannerTable();
  }

  Future<WeekBannerModel> getWeekBanner() async {
    final db = AppDb.instance;
    // final db = await database;
    final List<WeekBannerModel> banners = await db.getWeekBanners();
    return banners.first;
  }

  //TrendyColorModel DB

  Future<void> insertTrendyColor(TrendyColorModel color) async {
    final db = AppDb.instance;
    // final db = await database;
    await db.insertTrendyColor(color);
  }

  Future<List<TrendyColorModel>> getTrendyColors() async {
    final db = AppDb.instance;
    // final db = await database;
    final List<TrendyColorModel> trendyColors = await db.getTrendyColors();
    return trendyColors;
  }

  Future<void> clearTrendyColorTable() async {
    final db = AppDb.instance;
    // final db = await database;
    await db.clearTrendyColorTable();
  }

  //TRENDY TEXT DB Helper

  Future<void> insertTrendyText(String text) async {
    final db = AppDb.instance;
    await db.insertTrendyText(text);
  }

  Future<String> getTrendyText() async {
    final db = AppDb.instance;
    final String trendyText = await db.getTrendyText();
    return trendyText;
  }

  Future<void> clearTrendyTextTable() async {
    final db = AppDb.instance;
    await db.clearTrendyTextTable();
  }
}