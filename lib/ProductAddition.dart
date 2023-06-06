import 'package:flutter/material.dart';
import 'ShoppingList/ShoppingListPanel.dart';

class ProductAddition extends StatelessWidget {
  const ProductAddition({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 79, 146),
          title: const Text('Dodawanie produktu'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left_outlined,
              size: 40,
              color: Color.fromARGB(255, 135, 223, 154),
            ),
            onPressed: () => {runApp(const ShoppingListPanel())},
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
