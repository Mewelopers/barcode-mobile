import 'package:flutter/material.dart';

import 'jkp_colors.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final bool _showBackButton;

  const NavBar({super.key, required String title, bool showBackButton = true})
      : _showBackButton = showBackButton,
        _title = title;

  @override
  Widget build(BuildContext context) {
    if (_showBackButton) {
      return AppBar(
          backgroundColor: clrNeutral500,
          title: Text(_title),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 40,
                color: clrNeutral300,
              ),
              onPressed: () => Navigator.pop(context)));
    } else {
      return AppBar(
        backgroundColor: clrNeutral500,
        title: Text(_title),
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
