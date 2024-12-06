import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantone_book/screens/profile_page/widget/account_details.dart';
import 'package:pantone_book/screens/profile_page/widget/logout_button.dart';
import 'package:pantone_book/widgets/back_button.dart';

import '../../bloc/profile/profile_bloc.dart';

class MobileProfilePage extends StatefulWidget {
  const MobileProfilePage({super.key});

  @override
  State<MobileProfilePage> createState() => _MobileProfilePageState();
}

class _MobileProfilePageState extends State<MobileProfilePage> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Slide animation for other elements to appear from the bottom
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start position: below the screen
      end: const Offset(0, 0), // End position: original position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the slide animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(action: () {
                    _controller.reverse();
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfilePageEnterState) {
                  return Column(
                    children: [
                      Hero(
                        tag: 'profile-pic',
                        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.decelerate, // Custom curve for a bouncy effect
                          );
                          return ScaleTransition(
                            scale: curvedAnimation,
                            child: flightDirection == HeroFlightDirection.push
                                ? toHeroContext.widget
                                : fromHeroContext.widget,
                          );
                        },
                        child: const Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.circle_sharp, size: 200, color: Colors.blueGrey,),
                              Icon(Icons.circle_sharp, size: 190, color: Colors.white,),
                              Icon(Icons.person, size: 160,),
                            ],
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0),),
                            color: Color.fromARGB(255, 225, 237, 240),
                          ),
                          padding: EdgeInsets.only(left: 15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 320,
                          child: accountDetails(context, state, true),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
            logoutButton(context: context, isMobileMode: true),
          ],
        ),
      ),
    );
  }
}
