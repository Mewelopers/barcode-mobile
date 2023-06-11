import 'package:flutter/material.dart';

import '../../common/background.dart';
import '../../common/nav_bar.dart';

class ProductAddition extends StatelessWidget {
  const ProductAddition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(title: 'Dodaj nieznany produkt'),
      body: Container(
        decoration: background,
      ),
    );
  }
}
