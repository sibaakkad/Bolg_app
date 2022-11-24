import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/chache_helper.dart';
import '../login/pic_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'Open Your Knowledge Power1',
      body:
          'Motivation can take you far, but it can take you even futher if you first find your vision',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'Open Your Knowledge Power2',
      body:
          'Motivation can take you far, but it can take you even futher if you first find your vision',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'Open Your Knowledge Power3',
      body:
          'Motivation can take you far, but it can take you even futher if you first find your vision',
    ),
  ];
  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
            ),
            // const SizedBox(
            //   height: 60.0,
            // ),
            const SizedBox(
              height: 14.0,
            ),
            SmoothPageIndicator(
                controller: boardController,
                effect: ExpandingDotsEffect(
                  dotColor: HexColor('F2F2F2'),
                  activeDotColor: HexColor('333333'),
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  expansionFactor: 2,
                  spacing: 16.0,
                ),
                count: 3),
            const SizedBox(
              height: 48.0,
            ),
            defaultButton(
              function: () {
                submit();
              },
              text: 'Get Started',
              height: 70,
            ),
            const SizedBox(
              height: 22.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          defualtImage(height: 297.0, width: 197.66, borderRadius: 32.0),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'Open Your Knowledge Power',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
              color: defaultColorBlack,
              // height: 1.8,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Motivation can take you far, but it can take you even futher if you first find your vision',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: defaultColorGrey,
                // height: 1.8,
              ),
            ),
          ),
        ],
      );
}
