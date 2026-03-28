import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const OrderAppBar({super.key, required this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => drawerKey.currentState!.openDrawer(),
        icon: Icon(Icons.menu, color: AppColor.color4),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}