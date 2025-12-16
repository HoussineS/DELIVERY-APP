import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final FoodModel product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  bool _isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          buildBackround(),
          Container(
            width: AppConfig.screenWidth,
            height: AppConfig.screenHeight * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          Container(
            width: AppConfig.screenWidth,
            height: AppConfig.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  SizedBox(height: AppConfig.screenHeight * 0.1),
                  Center(
                    child: Hero(
                      tag: widget.product.imageCard,
                      child: Image.network(
                        widget.product.imageDetail,
                        fit: BoxFit.fill,
                        height: AppConfig.screenHeight * 0.4,
                      ),
                    ),
                  ),
                  SizedBox(height: AppConfig.screenHeight * 0.038),
                  Center(
                    child: Container(
                      width: AppConfig.screenWidth * 0.273,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,

                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity != 1 && _isEnabled) {
                                setState(() {
                                  _isEnabled = false;
                                  quantity--;
                                  _isEnabled = true;
                                });
                              }
                            },
                            icon: Icon(Icons.remove),
                            color: Colors.white,
                          ),
                          SizedBox(width: 0),
                          Text(
                            quantity.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 0),
                          IconButton(
                            onPressed: () {
                              if (_isEnabled && quantity != 99) {
                                setState(() {
                                  _isEnabled = false;
                                  quantity++;
                                  _isEnabled = true;
                                });
                              }
                            },
                            icon: Icon(Icons.add),
                            color: Colors.white,
                          ),
                        ],
                      ),
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

  Container buildBackround() {
    return Container(
      width: AppConfig.screenWidth,
      height: AppConfig.screenHeight,
      decoration: BoxDecoration(color: imageBackground),
      child: Image.asset(
        "assets/food-delivery/food pattern.png",
        repeat: ImageRepeat.repeatY,
        color: imageBackground2,
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      forceMaterialTransparency: true,

      actions: [
        SizedBox(width: AppConfig.screenWidth * 0.0655),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: EdgeInsets.all(8),
            height: AppConfig.screenHeight * 0.044,
            width: AppConfig.screenWidth * 0.097,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.all(8),
          height: AppConfig.screenHeight * 0.044,
          width: AppConfig.screenWidth * 0.097,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(Icons.more_horiz_rounded, color: Colors.black, size: 18),
        ),
        SizedBox(width: AppConfig.screenWidth * 0.0655),
      ],
    );
  }
}
