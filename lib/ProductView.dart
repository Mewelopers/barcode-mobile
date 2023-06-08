import 'package:barcode_mobile/common/Background.dart';
import 'package:barcode_mobile/shoppingList/ProductList.dart';
import 'package:flutter/material.dart';
import 'common/TopBar.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _ProductView(),
    );
  }
}

class _ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(backButtonDestination: ProductList()),
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
