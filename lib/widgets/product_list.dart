// ignore_for_file: avoid_print

import 'package:delivery_app/core/Provider/categorie_provider.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:delivery_app/pages/uI/view_all_product_ui.dart';
import 'package:delivery_app/widgets/product_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  // late Future<List<FoodModel>> _productFuture;
  // Future<List<FoodModel>> fecthProduct() async {
  //   try {
  //     final response = await Supabase.instance.client
  //         .from("menu_items")
  //         .select();
  //     return (response as List)
  //         .map((json) => FoodModel.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     print("Error on fetching product ${e.toString()}");
  //     return [];
  //   }
  // }

  // @override
  // void initState() {
  //   _productFuture = fecthProduct();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(categorieProvider);

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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_, _, _) => ViewAllProductUi(),
                      transitionsBuilder: (_, animation, _, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                child: Row(
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
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: AppConfig.screenHeight * 0.3,
            child: provider.isLoading
                ? Center(child: SpinKitCircle(color: Colors.amberAccent))
                : provider.filtredProduct.isEmpty
                ? Center(child: Text("No product"))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.filtredProduct.length,
                    itemBuilder: (context, index) {
                      final product = provider.filtredProduct[index];
                      print(product.imageCard);
                      return ProductStyle(product: product, index: index);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
