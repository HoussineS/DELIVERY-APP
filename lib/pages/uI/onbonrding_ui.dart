import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/on_bording_model.dart';
import 'package:flutter/material.dart';

class OnbonrdingUi extends StatefulWidget {
  const OnbonrdingUi({super.key});

  @override
  State<OnbonrdingUi> createState() => _OnbonrdingUiState();
}

class _OnbonrdingUiState extends State<OnbonrdingUi> {
  final PageController _pageController = PageController();
  int currenyPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: imageBackground,
      body: Stack(
        children: [
          SizedBox(
            height: AppConfig.screenHeight,
            width: AppConfig.screenWidth,
            child: Image.asset(
              "assets/food-delivery/food pattern.png",
              repeat: ImageRepeat.repeatY,
              color: imageBackground2,
            ),
          ),
          Positioned(
            top: -82,
            right: 0,
            left: 0,
            child: Image.asset("assets/food-delivery/chef.png"),
          ),
          Positioned(
            top: 139,
            right: 50,

            child: Image.asset(
              "assets/food-delivery/leaf.png",
              width: AppConfig.screenWidth * 0.12,
            ),
          ),
          Positioned(
            top: 350,
            right: 40,

            child: Image.asset(
              "assets/food-delivery/chili.png",
              width: AppConfig.screenWidth * 0.20,
            ),
          ),
          Positioned(
            top: 230,
            left: -10,

            child: Image.asset(
              "assets/food-delivery/ginger.png",
              width: AppConfig.screenWidth * 0.21,
              height: AppConfig.screenHeight * 0.098,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,

            child: ClipPath(
              clipper: CustumCliper(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: AppConfig.screenHeight * 0.19,
                      child: PageView.builder(
                        itemCount: data.length,
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            currenyPage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: data[index]['title1'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: data[index]['title2'],
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                data[index]['description']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              // SizedBox(height: AppConfig.screenHeight * 0.02),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(data.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: currenyPage == index ? 20 : 10,
                            height: 10,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: currenyPage == index
                                  ? Colors.orange
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: AppConfig.screenHeight * 0.02),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.redAccent,
                      height: AppConfig.screenHeight * 0.07,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Get Starded",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustumCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 30);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(size.width / 2, -30, 0, 30);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
