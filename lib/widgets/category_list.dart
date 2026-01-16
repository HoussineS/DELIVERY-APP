// ignore_for_file: avoid_print

import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<CategoryModel>> futureCategories = fetchCategories();
  List<CategoryModel> categories = [];
  String? selectedCategorie;

  @override
  void initState() {
    initialisationData();
    super.initState();
  }

  void initialisationData() async {
    try {
      final categories = await fetchCategories();
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          selectedCategorie = categories.first.name;
        });
      }
    } catch (e) {
      print("Error on intilaition data ${e.toString()}");
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('category_item')
          .select();
      print(response.length);
      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error on Loading Catecorie ${e.toString()}");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitPouringHourGlass(color: Colors.amberAccent),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox.shrink();
        }
        return SizedBox(
          height: AppConfig.screenHeight * 0.08,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final categoty = categories[index];
              bool isSelected = selectedCategorie == categoty.name;
              return Padding(
                padding: EdgeInsetsGeometry.only(
                  left: index == 0 ? 15 : 0,
                  right: 15,
                  top: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategorie = categoty.name;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : grey1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            categoty.image,
                            height: 35,
                            width: 35,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.fastfood),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          categoty.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
