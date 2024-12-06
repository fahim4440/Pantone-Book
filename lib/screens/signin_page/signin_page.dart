import 'package:flutter/material.dart';
import 'package:pantone_book/screens/signin_page/mobile_signin_page.dart';
import 'package:pantone_book/screens/signin_page/tablet_signin_page.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;
        if (availableWidth < 600) {
          return MobileSigninPage();
        } else {
          return TabletSigninPage();
        }
      },
    );
  }
}