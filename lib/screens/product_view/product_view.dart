import 'package:barcode_mobile/common/nav_bar.dart';
import 'package:barcode_mobile/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

import '../../common/background.dart';
import '../../models/shopping_list_item.dart';

class ProductView extends StatelessWidget {
  final ShoppingListItem _listItem;

  const ProductView({super.key, required ShoppingListItem listItem}) : _listItem = listItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: _listItem.name.capitalize()),
      body: Container(
        decoration: background,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Product Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/background.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Product Description',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
