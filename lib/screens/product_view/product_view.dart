import 'package:barcode_mobile/common/nav_bar.dart';
import 'package:barcode_mobile/extensions/string_extensions.dart';
import 'package:barcode_mobile/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/background.dart';
import '../../common/jkp_colors.dart';
import '../../constants/jkp_constants.dart';
import '../../di/injectable.dart';
import '../../models/product.dart';
import '../../models/shopping_list_item.dart';

class ProductView extends StatefulWidget {
  final ShoppingListItem _listItem;

  const ProductView({super.key, required ShoppingListItem listItem}) : _listItem = listItem;

  @override
  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends State<ProductView> {
  Product? _product;
  late final ShoppingListItem _listItem;
  final ProductService _productListService = getIt<ProductService>();

  @override
  void initState() {
    super.initState();
    _listItem = widget._listItem;
    getProduct();
  }

  Future<void> getProduct() async {
    var product = await _productListService.getProduct(_listItem.productBarcode!);
    setState(() {
      _product = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: _listItem.name.capitalize()),
      body: Container(
        width: double.infinity,
        decoration: background,
        child: _product == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(150, 71, 123, 143),
                ),
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
                        color: clrNeutral100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _listItem.thumbnailUrl == null
                              ? SvgPicture.asset(
                                  'assets/images/not_found.svg',
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  fit: BoxFit.fitHeight,
                                )
                              : Image.network(
                                  apiUrl + _listItem.thumbnailUrl!,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  fit: BoxFit.fitHeight,
                                ),
                          _listItem.barcodeImageUrl == null
                              ? SvgPicture.asset(
                                  'assets/images/not_found.svg',
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  fit: BoxFit.fitHeight,
                                )
                              : SvgPicture.network(
                                  apiUrl + _listItem.barcodeImageUrl!,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  fit: BoxFit.cover,
                                ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical, //.horizontal
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                _product!.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _product!.description ?? 'No description found',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
