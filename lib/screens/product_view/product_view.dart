import 'package:barcode_mobile/common/nav_bar.dart';
import 'package:barcode_mobile/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/background.dart';
import '../../constants/jkp_constants.dart';
import '../../models/shopping_list_item.dart';

class ProductView extends StatelessWidget {
  final ShoppingListItem _listItem;

  const ProductView({super.key, required ShoppingListItem listItem})
      : _listItem = listItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: _listItem.name.capitalize()),
      body: Container(
        width: double.infinity,
        decoration: background,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(
                    apiUrl + _listItem.thumbnailUrl!,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.fitHeight,
                  ),
                  // Transform.rotate(
                  //   angle: 3.14 / 2, // 90 degrees in radians
                  //   child:
                  SvgPicture.network(
                    apiUrl + _listItem.barcodeImageUrl!,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.cover,
                  ),
                  // ),
                ],
              ),
            ),
            const Text(
              'Product Name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
    );
  }
}
