import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/widgets/category_list.dart';
import 'package:delivery_app/widgets/custum_app_bar.dart';
import 'package:delivery_app/widgets/home_main_container.dart';
import 'package:delivery_app/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // custom AppBar
      appBar: CustumAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main container
            HomeMainContainer(),
            SizedBox(height: AppConfig.screenHeight * 0.027),
            Text(
              "Categories",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            //List of categories
            CategoryList(),
            SizedBox(height: AppConfig.screenHeight * 0.027),
            // list popular product
            ProductList(),
          ],
        ),
      ),
    );
  }
}
