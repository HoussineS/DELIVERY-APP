// ignore_for_file: avoid_print

import 'package:delivery_app/core/Provider/cart_provider.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CartUi extends ConsumerStatefulWidget {
  const CartUi({super.key});

  @override
  ConsumerState<CartUi> createState() => _CartUiState();
}

class _CartUiState extends ConsumerState<CartUi> {
  @override
  Widget build(BuildContext context) {
    final localCartProvider = ref.watch(cartProvider);
    double totalAmount = localCartProvider.getAmount();
    final cart = localCartProvider.cartItems;
    bool isLoding = false;

    return Scaffold(
      appBar: AppBar(title: Text("Cart"), centerTitle: true),
      body: cart.isEmpty
          ? Center(
              child: Text(
                "Cart is empty",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,

                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.redAccent,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) async {
                          try {
                            await localCartProvider.remove(item.id);
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        confirmDismiss: (_) async {
                          return await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Remove item?'),
                                  actions: [
                                    
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child:  Text('Remove'),
                                    ),
                                  ],
                                ),
                              ) ??
                              false;
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: Image.network(item.productData['imagecard']),
                          ),
                          title: Text(
                            item.productData['name'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Price: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    " \$${item.productData['price']}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Quantity: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${item.quantity}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                            width: AppConfig.screenWidth * 0.273,
                            height: AppConfig.screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,

                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove),
                                  color: Colors.white,
                                ),
                                SizedBox(width: 0),
                                Text(
                                  item.quantity.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 0),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
