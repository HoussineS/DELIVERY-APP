import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/color/colors.dart';
import 'package:delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

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
          _whiteContainer(),
          Container(
            width: AppConfig.screenWidth,
            height: AppConfig.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _foodImage(),
                  SizedBox(height: AppConfig.screenHeight * 0.038),
                  _mainButton(),
                  SizedBox(height: 20),
                  _priceAndNameContainer(),
                  SizedBox(height: 30),
                  _infoSummary(),
                  SizedBox(height: 25),
                  _description(),
                  SizedBox(height: AppConfig.screenHeight * 0.04),
                  AnimatedButton(),
                  // AnimatedAddButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ReadMoreText _description() {
    return ReadMoreText(
      widget.product.description,
      trimLength: 110,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
      trimExpandedText: "Read Less",
      trimCollapsedText: "Read More",
      moreStyle: TextStyle(fontWeight: FontWeight.w600, color: red),
    );
  }

  Row _infoSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconText(
          Icon(Icons.star, color: Colors.amber, size: 30),
          widget.product.rate.toString(),
        ),
        _buildIconText(
          Image.asset(
            "assets/food-delivery/icon/fire.png",
            height: 30,
            width: 30,
          ),
          "${widget.product.kcal} Kcal",
        ),
        _buildIconText(
          Image.asset(
            "assets/food-delivery/icon/time.png",
            height: 30,
            width: 30,
          ),
          widget.product.time,
        ),
      ],
    );
  }

  Row _priceAndNameContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.product.specialItems,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(width: AppConfig.screenWidth * 0.2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "\$",
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text: widget.product.price.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _foodImage() {
    return Container(
      width: AppConfig.screenWidth,
      height: AppConfig.screenHeight * 0.5,
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
          ],
        ),
      ),
    );
  }

  Container _whiteContainer() {
    return Container(
      width: AppConfig.screenWidth,
      height: AppConfig.screenHeight * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }

  Center _mainButton() {
    return Center(
      child: Container(
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
            Text(quantity.toString(), style: TextStyle(color: Colors.white)),
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

  Widget _buildIconText(Widget icon, String text) {
    return SizedBox(
      child: Row(
        children: [
          icon,
          SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: AppConfig.screenWidth * 0.8,
        height: AppConfig.usableHeight * 0.07,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isPressed ? Colors.green : red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(30),
            ),
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: Text(
              _isPressed ? "Added ✅" : "Add to Cart",
              style: TextStyle(fontSize: 16),
              key: ValueKey(_isPressed),
            ),
          ),
        ),
      ),
    );
  }
}



