import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pantone_book/bloc/signup/signup_bloc.dart';
import 'package:pantone_book/screens/signin_page/signin_page.dart';
import 'package:pantone_book/screens/signin_page/widget/email_text_field.dart';
import 'package:pantone_book/screens/signin_page/widget/password_text_field.dart';
import 'package:pantone_book/screens/signup_page/mobile_signup_page.dart';
import 'package:pantone_book/screens/signup_page/tablet_signup_page.dart';
import 'package:pantone_book/widgets/contact_footer.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;
        if (availableWidth < 600) {
          return MobileSignupPage();
        } else {
          return TabletSignupPage();
        }
      },
    );
  }
}