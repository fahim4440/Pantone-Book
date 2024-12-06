import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pantone_book/screens/homepage/widget/trendy_color_slideshow.dart';
import 'package:pantone_book/screens/homepage/widget/week_banner.dart';
import 'package:pantone_book/screens/page_navigation.dart';
import 'package:pantone_book/widgets/contact_footer.dart';
import 'package:pantone_book/widgets/circle_icon.dart';

import '../../bloc/search_color/color_search_bloc.dart';
import '../../model/pantone_model.dart';
import '../../repository/image_repository.dart';
import '../../widgets/alert_color_card.dart';
import '../../widgets/animation_container.dart';
import '../../widgets/color_list_tile.dart';
import '../../widgets/search_color_text_field.dart';
import '../profile_page/profile_page.dart';

class MobileHomepage extends StatefulWidget {
  final String name;
  const MobileHomepage({super.key, required this.name});

  @override
  State<MobileHomepage> createState() => _MobileHomepageState();
}

class _MobileHomepageState extends State<MobileHomepage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController
    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _footerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _uiAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Define slide animations for header and footer
    _headerOffsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -3.0))
        .animate(CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeInOut));
    _footerOffsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 10))
        .animate(CurvedAnimation(parent: _footerAnimationController, curve: Curves.easeInOut));
    _textOffsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(5, 0))
        .animate(CurvedAnimation(parent: _textAnimationController, curve: Curves.easeInOut));
    _rotateUiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _uiAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _headerAnimationController.dispose();
    _footerAnimationController.dispose();
    _textAnimationController.dispose();
    _uiAnimationController.dispose();
  }


  late AnimationController _headerAnimationController;
  late AnimationController _footerAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _uiAnimationController;
  late Animation<double> _rotateUiAnimation;
  late Animation<Offset> _headerOffsetAnimation;
  late Animation<Offset> _footerOffsetAnimation;
  late Animation<Offset> _textOffsetAnimation;


  final ImageRepository _imageRepository = ImageRepository();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: Alignment.center,
      children: [
        //Search UI in Z axis
        Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width - 60,
                      child: SearchColorTextField(context: context),
                    ),
                    circleIcon(action: () {
                      _headerAnimationController.reverse();
                      _textAnimationController.reverse();
                      _footerAnimationController.reverse();
                      _uiAnimationController.reverse();
                    }, icon: Icons.add, heroTag: 'search-cancel', angle: 3.1416/4),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ColorSearchBloc, ColorSearchState>(
                  builder: (context, state) {
                    if (state is ColorSearchLoadingState) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else if (state is ColorSearchErrorState) {
                      return Center(child: Text(state.errorMessage),);
                    } else if (state is ColorSearchLoadedState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.colors.length,
                        itemBuilder: (BuildContext context, int index) {
                          PantoneColor color = state.colors[index];
                          return Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(5.0),
                                onTap: () {
                                  showDialog(context: context, builder: (context) => AlertColorCard(context, color));
                                },
                                child: ColorListTile(context, color),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                child: const Divider(color: Colors.blueGrey,),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is ColorSearchInitial) {
                      return const SizedBox.shrink();
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        //HomeUI in X axis
        AnimatedBuilder(
          animation: _rotateUiAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Add perspective
                ..rotateY(-_rotateUiAnimation.value * (3.14159 / 2)), // Rotate Y-axis up to 90 degrees
              child: child,
            );
          },
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SlideTransition(
                      position: _headerOffsetAnimation,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            circleIcon(action: () {
                              Navigator.push(context, FadeAnimatedPageRoute(page: const ProfilePage()));
                            }, icon: Icons.person, heroTag: 'profile-pic'),
                            Column(
                              children: [
                                Text("Hello, ${widget.name.split(" ").first}", style: const TextStyle(fontWeight: FontWeight.bold),),
                                Text("Today ${DateFormat('ddMMM').format(DateTime.now())}", style: const TextStyle(fontSize: 10),),
                              ],
                            ),
                            circleIcon(action: () {
                              _headerAnimationController.forward();
                              _textAnimationController.forward();
                              _footerAnimationController.forward();
                              _uiAnimationController.forward();
                            }, icon: Icons.search, heroTag: 'search-start'),
                          ],
                        ),
                      ),
                    ),
                    // SlideTransition(
                    //   position: _textOffsetAnimation,
                    //   child: weekBanner(action: () {
                    //     // Navigator.push(context, FadeAnimatedPageRoute(page: const ColorOfTheWeekPage()));
                    //   }, screenWidth: width),
                    // ),
                    SlideTransition(
                      position: _textOffsetAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 5),
                                child: Text("Trendy Summer Color"),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 10, color: Colors.blueGrey,)
                            ],
                          ),
                          // TrendyColorSlideshow(),
                        ],
                      ),
                    ),
                  ],
                ),
                SlideTransition(
                  position: _textOffsetAnimation,
                  child: AnimationContainer(),
                ),
                SlideTransition(
                  position: _footerOffsetAnimation,
                  child: Column(
                    children: [
                      ContactFooter(),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: SlideTransition(
              position: _footerOffsetAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'fromCamera',
                    onPressed: () {
                      _imageRepository.pickImageFromCamera(context);
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                  const SizedBox(width: 20.0,),
                  FloatingActionButton(
                    heroTag: 'fromGallery',
                    onPressed: () {
                      _imageRepository.pickImageFromGallery(context);
                    },
                    child: const Icon(Icons.image),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}