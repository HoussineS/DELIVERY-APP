// ignore_for_file: avoid_print

import 'package:delivery_app/widgets/product_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/product_model.dart';

class ViewAllProductUi extends StatefulWidget {
  const ViewAllProductUi({super.key});

  @override
  State<ViewAllProductUi> createState() => _ViewAllProductUiState();
}

class _ViewAllProductUiState extends State<ViewAllProductUi> {
  bool _isLoading = false;
  late List<FoodModel> _products;
  Future<void> fecthAllProduct() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await Supabase.instance.client
          .from("menu_items")
          .select();
      final products = (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
      //filter with name ascending
      products.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      //update screen
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      print("Error on fetching product ${e.toString()}");
    }
  }

  @override
  void initState() {
    fecthAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Text(
          "All Product",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: SpinKitThreeInOut(color: Colors.blue, size: 50))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: index % 2 == 0 ? 5 : 0,
                  ),
                  child: ProductStyle(product: _products[index]),
                );
              },
            ),
    );
  }
}
