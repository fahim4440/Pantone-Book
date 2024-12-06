import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pantone_book/services/pantone_database/homepage_db_helper.dart';

import '../../../model/trendy_color_model.dart';
import '../../../model/week_banner_model.dart';


class HomepageRepository {
  final HomepageDbHelper _databaseHelper = HomepageDbHelper();

  Future<bool> _isInternetAvailable() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    // Check if there is no connectivity
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Additional check for actual internet access
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }


  Future<WeekBannerModel> fetchWeekBannerData() async {
    if (await _isInternetAvailable()) {
      try {
        final snapshot = await FirebaseFirestore.instance.collection('homepage').doc('colorWeekBanner').get();
        final WeekBannerModel banner = WeekBannerModel.fromMap(snapshot.data()!);

        // Update the local database
        await _databaseHelper.clearWeekBannerTable();
        await _databaseHelper.insertWeekBanner(banner);
        return banner; // Return data from Firebase
      } catch (e) {
        print('Error fetching WeekBannerModel from Firebase: $e');
        return _databaseHelper.getWeekBanner(); // Fallback to local database
      }
    } else {
      return _databaseHelper.getWeekBanner(); // Fallback to local database
    }
  }

  Future<String> fetchTrendyText() async {
    if (await _isInternetAvailable()) {
      try {
        final snapshot = await FirebaseFirestore.instance.collection("homepage").doc('trendyColor').get();
        final String trendyText = snapshot.data()?['trendyText'];

        // Update the local database
        await _databaseHelper.clearTrendyTextTable();
        await _databaseHelper.insertTrendyText(trendyText);
        return trendyText;
      } catch (e) {
        print('Error fetching Trendy Text from Firebase: $e');
        return _databaseHelper.getTrendyText(); // Fallback to local database
      }
    } else {
      return _databaseHelper.getTrendyText();
    }
  }

  Future<List<TrendyColorModel>> fetchTrendyColorData() async {
    if (await _isInternetAvailable()) {
      try {
        final snapshot = await FirebaseFirestore.instance.collection('homepage').doc('trendyColor').collection('trendyColors').get();
        final List<TrendyColorModel> colors = snapshot.docs.map((doc) {
          return TrendyColorModel.fromMap(doc.data());
        }).toList();

        // Update the local database
        await _databaseHelper.clearTrendyColorTable();
        await _databaseHelper.insertTrendyColor(colors.first);

        return colors; // Return data from Firebase
      } catch (e) {
        print('Error fetching TrendyColorModel from Firebase: $e');
        return _databaseHelper.getTrendyColors(); // Fallback to local database
      }
    } else {
      return _databaseHelper.getTrendyColors(); // Fallback to local database
    }
  }
}
