import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;

  const BaseAppBar({this.bottom, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/amazon-logo.png',
        width: 100,
      ),
      backgroundColor: const Color(0xFF232f3e),
      actions: [
        Padding(padding: EdgeInsets.only(right: 12.0), child: Icon(Icons.mic)),
        Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.shopping_cart_outlined)),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomSize = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomSize);
  }
}
