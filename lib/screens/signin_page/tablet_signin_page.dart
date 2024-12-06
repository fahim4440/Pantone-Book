import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pantone_book/screens/page_navigation.dart';

import 'widget/email_text_field.dart';
import 'widget/error_message.dart';
import 'widget/password_text_field.dart';
import 'widget/signin_button.dart';

import '../../widgets/contact_footer.dart';
import '../signup_page/signup_page.dart';

class TabletSigninPage extends StatefulWidget {
  const TabletSigninPage({super.key});

  @override
  State<TabletSigninPage> createState() => _TabletSigninPageState();
}

class _TabletSigninPageState extends State<TabletSigninPage> with TickerProviderStateMixin {
  late AnimationController _lottieAnimationController;
  late Animation<Offset> _slideLottieAnimation;

  late AnimationController _inputAnimationController;
  late Animation<Offset> _slideInputAnimation;

  @override
  void initState() {
    super.initState();

    _lottieAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _inputAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Slide animation for other elements to appear from the bottom
    _slideLottieAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Start position: below the screen
      end: const Offset(0, 0), // End position: original position
    ).animate(
      CurvedAnimation(parent: _lottieAnimationController, curve: Curves.easeOut),
    );

    _slideInputAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _inputAnimationController, curve: Curves.easeInOut),
    );

    // Start the slide animation
    _lottieAnimationController.forward();
    _inputAnimationController.forward();
  }

  @override
  void dispose() {
    _lottieAnimationController.dispose();
    _inputAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3.0,
        backgroundColor: const Color.fromARGB(255, 225, 237, 240),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'lottie',
                  child: SlideTransition(
                    position: _slideLottieAnimation,
                    child: Lottie.asset("assets/logo.json", width: width / 3 - 20.0,),
                  ),
                ),
                SizedBox(width: 30),
                VerticalDivider(width: 4, color: Colors.cyan[800],),
                SizedBox(width: 30),
                Expanded(
                  child: SlideTransition(
                    position: _slideInputAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 2 - 20,
                          child: const EmailInput(),
                        ),
                        const SizedBox(height: 30,),
                        SizedBox(
                          width: width / 2 - 20,
                          child: const PasswordInput(),
                        ),
                        const SizedBox(height: 40.0,),
                        const SigninButton(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, FadeAnimatedPageRoute(page: const SignupPage()));
                              },
                              child: const Text("Signup Now!"),
                            )
                          ],
                        ),
                        ErrorMessage(),
                        const SizedBox(height: 10.0,),
                        ContactFooter(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30,)
              ],
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}
