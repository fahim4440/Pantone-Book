import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pantone_book/screens/signin_page/widget/email_text_field.dart';
import 'package:pantone_book/screens/signin_page/widget/error_message.dart';
import 'package:pantone_book/screens/signin_page/widget/password_text_field.dart';
import 'package:pantone_book/screens/signin_page/widget/signin_button.dart';
import '../../widgets/contact_footer.dart';
import '../page_navigation.dart';
import '../signup_page/signup_page.dart';

class MobileSigninPage extends StatefulWidget {
  const MobileSigninPage({super.key});

  @override
  State<MobileSigninPage> createState() => _MobileSigninPageState();
}

class _MobileSigninPageState extends State<MobileSigninPage> with TickerProviderStateMixin {

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SlideTransition(
              position: _slideLottieAnimation,
              child: Lottie.asset("assets/logo.json", width: MediaQuery.of(context).size.width - 200.0, height: 200,),
            ),
            SlideTransition(
              position: _slideInputAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const EmailInput(),
                    const SizedBox(
                      height: 30,
                    ),
                    const PasswordInput(),
                    const SizedBox(
                      height: 40.0,
                    ),
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
                    const SizedBox(
                      height: 10.0,
                    ),
                    ContactFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

