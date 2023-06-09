import 'package:flutter/material.dart';
import 'ShoppingList.dart';
import 'products.dart';

class ProductAddition extends StatelessWidget {
  const ProductAddition({super.key});

  final List<Widget> products = const [
    const Product(),
    const Product(),
    const Product(),
  ];

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
            onPressed: () => {runApp(const ShoppingList())},
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,

            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 10),
                width: 300,
                height: 70,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 135, 223, 154),
                    borderRadius: BorderRadius.circular(40),
                ),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                                Icons.search,
                                size: 30),
                            Flexible(
                              child: TextField(),
                            ),
                          ]
                      )
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 0),
                width: 400,
                height: 588,
                decoration: BoxDecoration(
                  color: Color.fromARGB(171, 135, 223, 154),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  ),
                child: Center(
                  child: ListView(
                    children: products,
                  ),
                ),
                )
            ]
          ),
        ),
      ),
    );
  }
}
