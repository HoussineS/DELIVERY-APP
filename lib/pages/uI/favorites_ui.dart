import 'dart:async';

import 'package:delivery_app/core/Provider/favorite_provider.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesUi extends ConsumerStatefulWidget {
  const FavoritesUi({super.key});

  @override
  ConsumerState<FavoritesUi> createState() => _FavoritesUiState();
}

class _FavoritesUiState extends ConsumerState<FavoritesUi>
    with AutomaticKeepAliveClientMixin {
  List<FoodModel>? _favItems;
  List<String>? _lastProductIds;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // Initial fetch using current provider state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleProviderUpdate();
    });
  }

  void _handleProviderUpdate() {
    final provider = ref.read(favotiteProvider);
    final ids = List<String>.from(provider.getFav); // Copy list
    ids.sort();

    if (_lastProductIds != null && _listEquals(ids, _lastProductIds!)) return;

    _lastProductIds = ids;
    debugPrint("Favorites updated (Provider). New IDs: $ids");

    if (ids.isEmpty) {
      if (mounted) {
        setState(() {
          _favItems = [];
          _loading = false;
        });
      }
      return;
    }

    if (mounted) setState(() => _loading = true);
    _fetchFavItems(ids).then((items) {
      // Stale check: ensure provider hasn't changed while we were fetching
      final currentProviderIds = List<String>.from(
        ref.read(favotiteProvider).getFav,
      );
      currentProviderIds.sort();

      if (!_listEquals(ids, currentProviderIds)) {
        debugPrint("Discarding stale favorites fetch result.");
        return;
      }

      if (mounted) {
        setState(() {
          _favItems = items;
          _loading = false;
        });
      }
    });
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<List<FoodModel>> _fetchFavItems(List<String> ids) async {
    try {
      final response = await Supabase.instance.client
          .from('menu_items')
          .select()
          .inFilter('name', ids);
      print("loded");
      return response.map((e) => FoodModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching favorites: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Listen to changes in the provider
    ref.listen(favotiteProvider, (previous, next) {
      _handleProviderUpdate();
    });

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
      body: _loading
          ? const SpinKitFadingCircle(color: Colors.amber)
          : _favItems == null || _favItems!.isEmpty
          ? const Center(
              child: Text(
                "You don't have favorite yet!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: _favItems!.length,
              itemBuilder: (context, index) {
                final favItem = _favItems![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
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
                                  image: NetworkImage(favItem.imageCard),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
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
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Consumer(
                            builder: (context, ref, child) {
                              return GestureDetector(
                                onTap: () {
                                  // Assuming name is the productId/key as per logic
                                  ref
                                      .read(favotiteProvider)
                                      .toogleFav(favItem.name);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: red,
                                    size: 25,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
