import 'package:flutter/material.dart';
import 'package:pantone_book/screens/homepage/desktop_homepage.dart';
import 'package:pantone_book/screens/homepage/mobile_homepage1.dart';
import 'package:pantone_book/screens/homepage/tablet_homepage.dart';
import '../../services/pantone_database/pantone_db_helper.dart';

class Homepage extends StatefulWidget {
  final String name;
  const Homepage({super.key, required this.name});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _pantoneDBHelper.initializePantoneDatabase();
  }
  final PantoneDBHelper _pantoneDBHelper = PantoneDBHelper();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check the available width and height in constraints
        double availableWidth = constraints.maxWidth;
        if (availableWidth < 600) {
          return MobileHomepage1(name: widget.name);
        } else if (availableWidth >= 600 && availableWidth < 1200) {
          return TabletHomepage(name: widget.name,);
        } else {
          return DesktopHomepage(name: widget.name,);
        }
      },
    );
  }
}