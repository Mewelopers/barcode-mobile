import 'package:flutter/material.dart';
import 'ProductTile.dart';

// This class will handle extraction of products in shopping list from DB
class ProductList extends StatelessWidget {
  ProductList({super.key});

  List<Widget> products = [
    ProductTile(productName: 'AAAA'),
    ProductTile(productName: 'BBBB'),
    ProductTileWithInfo(productName: 'CCCC'),
    ProductTileWithInfo(productName: 'DDDD'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB'),
    ProductTile(productName: 'BBBB')
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
            shrinkWrap: true,
            children: products
        )
    );
  }
}