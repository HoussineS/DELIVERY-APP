import 'package:delivery_app/core/Provider/favorite_provider.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:delivery_app/pages/uI/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductStyle extends ConsumerStatefulWidget {
  const ProductStyle({super.key, required this.product, this.index});
  final FoodModel product;
  final int? index;
  @override
  ConsumerState<ProductStyle> createState() => _ProductStyleState();
}

class _ProductStyleState extends ConsumerState<ProductStyle> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(favotiteProvider);
    final product = widget.product;
    bool isEnabled = true;
    return Container(
      height: AppConfig.screenHeight * 0.01,
      width: AppConfig.screenWidth * 0.45,

      margin: EdgeInsets.only(left: widget.index == 0 ? 20 : 0, right: 20),
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

            child: GestureDetector(
              onTap: isEnabled
                  ? () async {
                      setState(() {
                        isEnabled = false;
                      });
                      await provider.toogleFav(product.name);
                      setState(() {
                        isEnabled = true;
                      });
                    }
                  : null,
              child: Container(
                width: AppConfig.screenWidth * 0.073,
                height: AppConfig.screenHeight * 0.033,
                decoration: BoxDecoration(
                  color: provider.isFav(product.name)
                      ? Colors.red[100]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Image.asset(
                  "assets/food-delivery/icon/fire.png",
                  scale: 2,
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  pageBuilder: (_, _, _) => ProductDetails(product: product),
                ),
              );
            },
            child: Hero(
              tag: product.imageCard,
              child: Image.network(
                product.imageCard,
                height: AppConfig.screenHeight * 0.12,
                width: AppConfig.screenWidth * 0.5,
                fit: BoxFit.contain,
              ),
            ),
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: AppConfig.screenHeight * 0.011),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\$ ",
                    style: TextStyle(fontSize: 16, color: Colors.red),
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
  }
}
