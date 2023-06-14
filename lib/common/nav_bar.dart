import 'package:barcode_mobile/screens/list_of_lists/list_of_lists.dart';
import 'package:barcode_mobile/screens/product_addition/product_addition.dart';
import 'package:barcode_mobile/screens/product_list/product_list.dart';
import 'package:flutter/material.dart';

import 'jkp_colors.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final bool _showBackButton;
  final Widget parrent;

  const NavBar({super.key, required String title, bool showBackButton = true, required this.parrent})
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
          onPressed: () {
            if (parrent.runtimeType.toString() == (ProductAddition).toString() ||
                parrent.runtimeType.toString() == (ProductList).toString()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListOfLists()
                  )
              );
            }
            else {
              Navigator.pop(context);
            }
          },
        ),
      );
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
