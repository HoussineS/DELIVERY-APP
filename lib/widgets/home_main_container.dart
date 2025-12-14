import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:flutter/material.dart';

class HomeMainContainer extends StatelessWidget {
  const HomeMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConfig.screenHeight * 0.2,
      width: AppConfig.screenWidth * 0.95,
      decoration: BoxDecoration(
        color: imageBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "The Fastest In Delivery ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Food',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppConfig.screenHeight * 0.01),
                MaterialButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   PageRouteBuilder(
                    //     transitionDuration: Duration(milliseconds: 400),
                    //     pageBuilder: (_, __, ___) => AppMainHomeScreen(),
                    //     transitionsBuilder: (_, animation, __, child) {
                    //       return FadeTransition(
                    //         opacity: animation,
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  color: Colors.redAccent,
                  height: AppConfig.screenHeight * 0.05,
                  minWidth: 140,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Order Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Image.asset(
            "assets/food-delivery/courier.png",
            height: AppConfig.screenHeight * 0.15,
            width: AppConfig.screenWidth * 0.5,
          ),
        ],
      ),
    );
  }
}
