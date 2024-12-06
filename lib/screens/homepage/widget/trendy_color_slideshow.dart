import 'package:flutter/material.dart';
import 'package:pantone_book/model/trendy_color_model.dart';

import 'dart:async';

import '../../../model/pantone_model.dart';
import '../../../widgets/alert_color_card.dart';

class TrendyColorSlideshow extends StatefulWidget {
  final List<TrendyColorModel> trendyColorModels;
  final double width;
  const TrendyColorSlideshow({required this.trendyColorModels, required this.width, super.key});

  @override
  TrendyColorSlideshowState createState() => TrendyColorSlideshowState();
}

class TrendyColorSlideshowState extends State<TrendyColorSlideshow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.trendyColorModels.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOutBack,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 150,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.trendyColorModels.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    TrendyColorModel model = widget.trendyColorModels[index];
                    Color fontColor = Color.fromARGB(255, model.cardColorR, model.fontColorG, model.fontColorB);
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      color: Color.fromARGB(255, model.cardColorR, model.cardColorG, model.cardColorB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          showDialog(context: context, builder: (context) => AlertColorCard(context, PantoneColor(id: 1, pantoneCode: model.tcxCode, colorName: model.colorName, red: model.cardColorR, green: model.cardColorG, blue: model.cardColorB)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.tcxCode, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: fontColor),),
                                  Text(model.colorName, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: fontColor),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: widget.width / 2 - (widget.trendyColorModels.length * 5),
                  bottom: 15,
                  width: widget.width,
                  height: 10,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.trendyColorModels.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Icon(Icons.circle, size: 8, color: _currentPage == index ? Colors.black : Colors.black12,),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
