import 'package:delivery_app/core/color/colors.dart';
import 'package:flutter/material.dart';

class CustumAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustumAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        SizedBox(width: 30),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(color: grey1),
          child: Image.asset('assets/food-delivery/icon/dash.png'),
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Colors.red, size: 18),
            SizedBox(width: 2),
            Text(
              'California,US',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
        Spacer(),
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/food-delivery/profile.png'),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
