import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/animated_text_field.dart';
import 'widget/color_grid_tile.dart';
import 'widget/profile_card.dart';
import 'widget/week_trendy_widget.dart';

import '../../model/pantone_model.dart';
import '../../bloc/homepage/homepage_bloc.dart';
import '../../repository/image_repository.dart';
import '../../widgets/alert_color_card.dart';
import '../../widgets/animation_container.dart';
import '../../widgets/contact_footer.dart';
import '../page_navigation.dart';
import '../profile_page/profile_page.dart';

class TabletHomepage extends StatefulWidget {
  final String name;
  const TabletHomepage({super.key, required this.name});

  @override
  State<TabletHomepage> createState() => _TabletHomepageState();
}

class _TabletHomepageState extends State<TabletHomepage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  bool _isSearchActive = false;

  @override
  void initState() {
    context.read<HomepageBloc>().add(HomepageInitialEvent());
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define the Tween for smooth position changes
    _positionAnimation = Tween<double>(begin: 280, end: 50).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _startAnimation(true); // Move the text field up
      } else {
        // _startAnimation(false); // Move the text field down
      }
    });
  }

  void _startAnimation(bool moveUp) {
    setState(() {
      _isSearchActive = moveUp;
    });

    if (moveUp) {
      // _animationController.forward(); // Start the animation (move up)
      _animationController.forward().then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_focusNode.hasFocus) {
            _focusNode.requestFocus(); // Request focus after animation completes
          }
        });
      });
    } else {
      _animationController.reverse(); // Reverse the animation (move down)
    }
  }

  void _onCancel() {
    _focusNode.unfocus(); // Triggers the animation back down
    _animationController.reverse();
    setState(() {
      _isSearchActive = false;
    });
  }

  final ImageRepository _imageRepository = ImageRepository();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        // Main UI Content
        Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: profileCard(action: () {
                          Navigator.push(context, FadeAnimatedPageRoute(page: const ProfilePage()));
                        }, name: widget.name),),
                      SizedBox(height: 5,),
                    ],
                  ),
                  BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, state) {
                      if (state is HomepageInitial) {
                        return Center(child: CircularProgressIndicator(),);
                      } else if (state is HomepageLoadingState) {
                        return Center(child: CircularProgressIndicator(),);
                      } else if (state is HomepageErrorState) {
                        return Center(child: Text(state.errorMessage),);
                      } else if (state is HomepageUiLoadedState) {
                        return weekTrendyWidget(width: width, weekBannerModel: state.weekBannerModel, trendyText: state.trendyText, trendyColorModels: state.trendyColorModels);
                      } else if (state is HomepageSearchLoadedState) {
                        return weekTrendyWidget(width: width, weekBannerModel: state.weekBannerModel, trendyText: state.trendyText, trendyColorModels: state.trendyColorModels);
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              AnimationContainer(),
              Column(
                children: [
                  ContactFooter(),
                  const SizedBox(height: 10,),
                ],
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Platform.isAndroid ? FloatingActionButton(
                heroTag: 'fromCamera',
                onPressed: () {
                  _imageRepository.pickImageFromCamera(context);
                },
                child: const Icon(Icons.camera_alt),
              ) : SizedBox.shrink(),
              Platform.isIOS ? FloatingActionButton(
                heroTag: 'fromCamera',
                onPressed: () {
                  _imageRepository.pickImageFromCamera(context);
                },
                child: const Icon(Icons.camera_alt),
              ) : SizedBox.shrink(),
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

        // Overlay for Search
        if (_isSearchActive)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.95),
            ),
          ),


        // Animated TextField
        BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            if (state is HomepageInitial) {
              return SizedBox.shrink();
            } else if (state is HomepageLoadingState) {
              return SizedBox.shrink();
            } else if (state is HomepageUiLoadedState) {
              return animatedTextField(
                positionAnimation: _positionAnimation,
                isSearchActive: _isSearchActive,
                width: width,
                focusNode: _focusNode,
                controller: _controller,
                onCancel: _onCancel,
                weekBannerModel: state.weekBannerModel,
                trendyText: state.trendyText,
                trendyColors: state.trendyColorModels,
                isDesktopMode: false,
              );
            } else if (state is HomepageSearchLoadedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Ensure the text field stays focused after results are loaded
                if (!_focusNode.hasFocus && _isSearchActive) {
                  _focusNode.requestFocus();
                }
              });
              return animatedTextField(
                positionAnimation: _positionAnimation,
                isSearchActive: _isSearchActive,
                width: width,
                focusNode: _focusNode,
                controller: _controller,
                onCancel: _onCancel,
                weekBannerModel: state.weekBannerModel,
                trendyText: state.trendyText,
                trendyColors: state.trendyColorModels,
                isDesktopMode: false,
              );
            }
            return SizedBox.shrink();
          },
        ),

        // Search Results
        if (_isSearchActive)
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return Positioned(
                top: _positionAnimation.value + 60,
                left: 16,
                right: 16,
                bottom: 0,
                child: BlocBuilder<HomepageBloc, HomepageState>(
                  builder: (context, state) {
                    if (state is HomepageSearchLoadedState) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8, // Space between columns
                          mainAxisSpacing: 8, // Space between rows
                        ),
                        itemCount: state.colors.length,
                        itemBuilder: (context, index) {
                          PantoneColor color = state.colors[index];
                          return colorGridTile(action: () {
                            showDialog(context: context, builder: (context) => AlertColorCard(context, color));
                          }, color: color);
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              );
            }
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
