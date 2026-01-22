import 'package:delivery_app/core/Provider/favorite_provider.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/pages/uI/favorites_ui.dart';
import 'package:delivery_app/pages/ui/home.dart';
import 'package:delivery_app/pages/uI/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppMainHomeScreen extends StatefulWidget {
  const AppMainHomeScreen({super.key});

  @override
  State<AppMainHomeScreen> createState() => _AppMainHomeScreenState();
}

class _AppMainHomeScreenState extends State<AppMainHomeScreen> {
  int currentIndex = 0;
  final List<Widget> _pages = const [
    Home(),
    FavoritesUi(),
    ProfileScreen(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  IndexedStack(
  index: currentIndex,
  children: List.generate(
    _pages.length,
    (i) => _AnimatedTab(
      isActive: currentIndex == i,
      child: _pages[i],
    ),
  ),
),
      bottomNavigationBar: Container(
        height: AppConfig.screenHeight * 0.09,
        color: Colors.white,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -30,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.red,

                child: Icon(
                  CupertinoIcons.search,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: AppConfig.screenWidth * 0.00001),
                _buildNavItem(Iconsax.home_15, 0, "A"),

                _buildNavItem(Iconsax.heart, 1, "B"),
                SizedBox(width: AppConfig.screenWidth * 0.1),

                _buildNavItem(Icons.person_outline, 2, "C"),

                Badge(
                  label: Text("0"),
                  textStyle: TextStyle(fontSize: 12),
                  textColor: Colors.red,

                  child: _buildNavItem(Iconsax.shopping_cart, 3, '2'),
                ),
                SizedBox(width: AppConfig.screenWidth * 0.00001),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
        if (index == 1) {
          favoritesRefreshNotifier.value++;
        }
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: currentIndex == index ? Colors.red : Colors.grey,
          ),
          SizedBox(height: 5),
          CircleAvatar(
            radius: 3,
            backgroundColor: currentIndex == index
                ? Colors.red
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class _AnimatedTab extends StatelessWidget {
  final bool isActive;
  final Widget child;

  const _AnimatedTab({
    required this.isActive,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isActive ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 250),
          offset: isActive ? Offset.zero : const Offset(0.03, 0),
          child: child,
        ),
      ),
    );
  }
}


