import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../common/background.dart';
import '../../common/nav_bar.dart';
import '../product_list/bottom_nav_bar.dart';
import '../../models/shopping_list.dart';
import '../../common/jkp_colors.dart';
import 'package:barcode_mobile/models/product.dart';
import '../../services/product_service.dart';
import 'package:barcode_mobile/di/injectable.dart';
import 'searchResultProductTile.dart';

class ProductAddition extends StatefulWidget {
  final Function addProductFromList;
  final Function addNewProduct;
  final ShoppingList shoppingList;

  const ProductAddition(
      {super.key,
      required this.shoppingList,
      required this.addNewProduct,
      required this.addProductFromList});

  @override
  ProductAdditionState createState() => ProductAdditionState();
}

class ProductAdditionState extends State<ProductAddition> {
  List<Product> searchedItems = [];
  final ProductService productDbSearch = getIt<ProductService>();
  Widget resultList = Expanded(child: Container());

  Future<void> updateSearchedItems(String nameToSearch) async {
    searchedItems = await productDbSearch.getMatchingItems(nameToSearch);
    if (nameToSearch.isEmpty) searchedItems = [];
    setState(() {
      resultList = Expanded(
          child: ListView.builder(
              itemCount: searchedItems.length, //searchedItems.length,
              itemBuilder: (context, index) {
                return SearchResultProductTile(
                    product: searchedItems[index],
                    addNewProduct: widget.addNewProduct,
                    addProductFromList: widget.addProductFromList);
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const NavBar(title: 'Dodawanie produktu'),
        body: GestureDetector(
            onTap: () {
              // Clear focus of text field
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: background,
              child: Column(children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                      top: 20, right: 20, left: 20, bottom: 10),
                  padding: const EdgeInsets.only(left: 18),
                  decoration: BoxDecoration(
                    color: clrNeutral300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: TextField(
                              onChanged: (value) {
                                updateSearchedItems(value);
                              },
                              autofocus: false,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Wyszukaj produkt',
                                  hintStyle: TextStyle(fontSize: 20)),
                              style: const TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ),
                resultList,
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(left: 18),
                  decoration: BoxDecoration(
                    color: clrNeutral300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Dodaj własny produkt',
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: FloatingActionButton.small(
                              heroTag: "AddCustomProduct",
                              backgroundColor: Colors.black,
                              child: const Icon(Icons.add,
                                  color: Color.fromARGB(255, 213, 206, 239)),
                              onPressed: () {
                                widget.addNewProduct(null);
                              }))
                    ],
                  ),
                )
              ]),
            )),
        bottomNavigationBar: BottomNavBar(
            addNewProduct: widget.addNewProduct,
            addProductFromList: widget.addProductFromList,
            index: 0,
            shoppingList: widget.shoppingList));
  }
}
