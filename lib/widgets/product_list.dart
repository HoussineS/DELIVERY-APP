// ignore_for_file: avoid_print

import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<FoodModel>> _productFuture;
  Future<List<FoodModel>> fecthProduct() async {
    try {
      final response = await Supabase.instance.client
          .from("menu_items")
          .select();
      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error on fetching product ${e.toString()}");
      return [];
    }
  }

  @override
  void initState() {
    _productFuture = fecthProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Now",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              Row(
                children: [
                  Text(
                    "View All",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.amberAccent,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(color: Colors.amberAccent),
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: AppConfig.screenHeight * 0.3,
            child: FutureBuilder(
              future: _productFuture,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(color: Colors.amberAccent),
                  );
                }
                if (!asyncSnapshot.hasData ||
                    asyncSnapshot.hasError ||
                    asyncSnapshot.data!.isEmpty) {
                  return Center(child: Text("No product"));
                }
                // sort it ascending from name
                asyncSnapshot.data!.sort(
                  (a, b) => a.name[0].toLowerCase().compareTo(
                    b.name[0].toLowerCase(),
                  ),
                );

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: asyncSnapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = asyncSnapshot.data![index];
                    print(product.imageCard);
                    return Container(
                      height: AppConfig.screenHeight * 0.01,
                      width: AppConfig.screenWidth * 0.45,

                      margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 0,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 10,
                            spreadRadius: 10,
                            offset: Offset(0, 4), // shadow direction
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(right: 10, top: 5),

                            child: Container(
                              width: AppConfig.screenWidth * 0.073,
                              height: AppConfig.screenHeight * 0.033,
                              decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Image.asset(
                                "assets/food-delivery/icon/fire.png",

                                scale: 2,
                              ),
                            ),
                          ),

                          Image.network(
                            product.imageCard,
                            height: AppConfig.screenHeight * 0.12,
                            width: AppConfig.screenWidth * 0.5,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: AppConfig.screenHeight * 0.011),
                          Center(
                            child: Text(
                              product.name,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: AppConfig.screenHeight * 0.011),
                          Center(
                            child: Text(
                              product.specialItems,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: AppConfig.screenHeight * 0.011),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "\$ ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                  TextSpan(
                                    text: product.price.toStringAsFixed(2),
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
