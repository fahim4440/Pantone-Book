import 'package:flutter/material.dart';
import 'mobile_profile_page.dart';
import 'tablet_profile_page.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check the available width and height in constraints
        double availableWidth = constraints.maxWidth;
        if (availableWidth < 600) {
          return MobileProfilePage();
        } else {
          return TabletProfilePage();
        }
      },
    );
  }
}


