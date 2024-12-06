import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantone_book/screens/profile_page/widget/account_details.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../widgets/back_button.dart';
import '../signin_page/signin_page.dart';

class TabletProfilePage extends StatefulWidget {
  const TabletProfilePage({super.key});

  @override
  State<TabletProfilePage> createState() => _TabletProfilePageState();
}

class _TabletProfilePageState extends State<TabletProfilePage> with TickerProviderStateMixin {

  late AnimationController _buttonAnimationController;
  late Animation<Offset> _slideButtonAnimation;

  late AnimationController _detailsAnimationController;
  late Animation<Offset> _slideDetailsAnimation;

  @override
  void initState() {
    super.initState();

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _detailsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Slide animation for other elements to appear from the bottom
    _slideButtonAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start position: below the screen
      end: const Offset(0, 0), // End position: original position
    ).animate(
      CurvedAnimation(parent: _buttonAnimationController, curve: Curves.easeOut),
    );

    _slideDetailsAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _detailsAnimationController, curve: Curves.easeInOut),
    );

    // Start the slide animation
    _buttonAnimationController.forward();
    _detailsAnimationController.forward();
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _detailsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(action: () {
                  _buttonAnimationController.reverse();
                  _detailsAnimationController.reverse();
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'profile-pic',
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.circle_sharp, size: 250, color: Colors.blueGrey),
                      Icon(Icons.circle_sharp, size: 240, color: Colors.white),
                      Icon(Icons.person, size: 200),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                VerticalDivider(width: 4, color: Colors.cyan[800],),
                SizedBox(width: 30),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfilePageEnterState) {
                      return SlideTransition(
                        position: _slideDetailsAnimation,
                        child: accountDetails(context, state, false),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          SlideTransition(
            position: _slideButtonAnimation,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state.isSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SigninPage()),
                              (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return state.isSubmitting ? const Center(child: CircularProgressIndicator(),) :
                        MaterialButton(
                          onPressed: () {
                            context.read<ProfileBloc>().add(ProfileLoggedOutEvent());
                          },
                          color: Colors.white,
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return state.isFailure ?
                      Padding(padding: const EdgeInsets.only(top: 8.0),
                        child: Text(state.errorMessage,
                            style: const TextStyle(color: Colors.red)),
                      ) : Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
