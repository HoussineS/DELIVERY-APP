import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesUi extends StatefulWidget {
  const FavoritesUi({super.key});

  @override
  State<FavoritesUi> createState() => _FavoritesUiState();
}

class _FavoritesUiState extends State<FavoritesUi> {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: userId == null
          ? Center(
              child: Text(
                "You need login to view Favorited",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          : StreamBuilder(
              stream: Supabase.instance.client
                  .from("favorites")
                  .stream(primaryKey: ['id'])
                  .eq("userId", userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitFadingCircle(color: Colors.amber);
                }

                return FutureBuilder(
                  future: _fetchFavItems(snapshot.data!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SpinKitFadingCircle(color: Colors.amber);
                    }
                    final favItems = snapshot.data!;
                    if (favItems.isEmpty) {
                      return Center(
                        child: Text(
                          "You don't have favorite yet!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: favItems.length,
                      itemBuilder: (context, index) {
                        final favItem = favItems[index];
                        return Stack(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: AppConfig.screenWidth * 0.27,
                                      height: AppConfig.screenHeight * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            favItem.imageCard,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsGeometry.only(
                                              right: 20,
                                            ),
                                            child: Text(
                                              favItem.name,
                                              style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(favItem.category),
                                          Text(
                                            "\$${favItem.price.toStringAsFixed(2)}",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              child: GestureDetector(
                                child: Icon(Icons.delete, color: red, size: 25),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  Future<List<FoodModel>> _fetchFavItems(
    List<Map<String, dynamic>> favorites,
  ) async {
    final productsNames = favorites
        .map((fav) => fav['productId'].toString())
        .toList();
    if (productsNames.isEmpty) return [];
    try {
      final response = await Supabase.instance.client
          .from('menu_items')
          .select()
          .inFilter("name", productsNames);
      return response.map((food) => FoodModel.fromJson(food)).toList();
    } catch (e) {
      debugPrint('Eroor on favorites items on UI ${e.toString()}');
      return [];
    }
  }
}
