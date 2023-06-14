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

  const ProductAddition({super.key, required this.shoppingList, required this.addNewProduct, required this.addProductFromList});

  @override
  ProductAdditionState createState() => ProductAdditionState();
}

class ProductAdditionState extends State<ProductAddition> {
  List<Product> searchedItems = [];
  final ProductService productDbSearch = getIt<ProductService>();
  Widget resultList = Container();

  Future<void> updateSearchedItems(String nameToSearch) async {
    searchedItems = await productDbSearch.getMatchingItems(nameToSearch);
    setState(() {
      resultList = Expanded(
          child: ListView.builder(
              itemCount: searchedItems.length,//searchedItems.length,
              itemBuilder: (context, index) {
                return SearchResultProductTile(
                    product: searchedItems[index],
                    addNewProduct: widget.addNewProduct,
                    addProductFromList: widget.addProductFromList
                );
              }
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(title: 'Dodawanie produktu', parrent: context.widget),
        body: Container(
          decoration: background,
          child: Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                    // bottom: 4
                ),
                padding: const EdgeInsets.only(left: 18),
                decoration: BoxDecoration(
                  color: clrNeutral300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: TextField(
                          onChanged: (value) {
                            updateSearchedItems(value);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              resultList
            ]
          ),
        ),
        bottomNavigationBar: BottomNavBar(
            addNewProduct: widget.addNewProduct,
            addProductFromList: widget.addProductFromList,
            index: 0,
            shoppingList: widget.shoppingList)
    );
  }
}