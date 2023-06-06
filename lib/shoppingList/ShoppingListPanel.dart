import 'package:barcode_mobile/shoppingList/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:barcode_mobile/common/TopBar.dart';
import 'package:barcode_mobile/common/Background.dart';
import 'ListNameBox.dart';
import 'package:barcode_mobile/main.dart';
import 'BottomNavBar.dart';

class ShoppingListPanel extends StatelessWidget {
  const ShoppingListPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: TopBar(backButtonDestination: const MyApp()),
        body: Container(
          decoration: background,
          child: Column(
            children: [
              ListNameBox(),
              ProductList()
            ]
          ),
        ),
        bottomNavigationBar: BottomNavBar()
      )
    );
  }
}
