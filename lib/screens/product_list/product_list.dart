import 'package:barcode_mobile/di/injectable.dart';
import 'package:barcode_mobile/extensions/string_extensions.dart';
import 'package:barcode_mobile/models/shopping_list_item.dart';
import 'package:barcode_mobile/screens/product_list/product_tile.dart';
import 'package:flutter/material.dart';

import '../../common/background.dart';
import '../../common/jkp_colors.dart';
import '../../common/nav_bar.dart';
import '../../models/shopping_list.dart';
import '../../services/product_list_service.dart';
import 'bottom_nav_bar.dart';

class ProductList extends StatefulWidget {
  final ShoppingList _shoppingList;

  const ProductList({super.key, required ShoppingList shoppingList}) : _shoppingList = shoppingList;

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  List<ShoppingListItem> _items = [];
  bool _isLoading = true;
  late ShoppingList _shoppingList;
  final ProductListService _productListService = getIt<ProductListService>();

  @override
  void initState() {
    super.initState();
    _shoppingList = widget._shoppingList;
    getItems().then((value) => toggleLoading());
  }

  Future<void> getItems() async {
    final listItems = await _productListService.getProductListItems(_shoppingList.id);
    _items = [];

    setState(() {
      _items.addAll(listItems);
    });
  }

  void toggleLoading() {
    setState(() => _isLoading = !_isLoading);
  }

  Future<void> deleteListItem(int id) async {
    setState(() => _isLoading = true);
    await _productListService.deleteProductListItem(id);
    await getItems();
    setState(() => _isLoading = false);
  }

  Future<void> editListItem(int id, String name, String? barcode) async {
    setState(() => _isLoading = true);
    await _productListService.editList(id, name, barcode);
    await getItems();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: _shoppingList.listTitle.capitalize()),
      body: RefreshIndicator(
        onRefresh: () async {
          await getItems();
        },
        child: Container(
          decoration: background,
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.access_time_sharp, size: 64),
                          Text('No items found'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                            listItem: _items[index], editListItem: editListItem, deleteListItem: deleteListItem);
                      },
                    ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
