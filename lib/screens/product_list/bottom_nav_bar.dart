import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../common/jkp_colors.dart';
import '../product_addition/product_addition.dart';
import 'product_list.dart';
import '../../models/shopping_list.dart';

class BottomNavBar extends StatefulWidget {
  final Function addProductFromList;
  final Function addNewProduct;
  final int index;
  final ShoppingList shoppingList;

  const BottomNavBar(
      {super.key,
      required this.addProductFromList,
      required this.addNewProduct,
      required this.index,
      required this.shoppingList});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      type: BottomNavigationBarType.fixed,
      backgroundColor: clrNeutral500,
      unselectedItemColor: clrAccent200,
      selectedItemColor: clrNeutral300,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Dodaj",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Produkty",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.barcode_reader),
          label: "Skanuj kod",
        ),
      ],
      onTap: (int option) async {
        if (option != widget.index) {
          switch (option) {
            case 0:
              {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ProductAddition(
                              shoppingList: widget.shoppingList,
                              addNewProduct: widget.addNewProduct,
                              addProductFromList: widget.addProductFromList),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));

                break;
              }
            case 1:
              {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ProductList(shoppingList: widget.shoppingList),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
                break;
              }
            case 2:
              {
                var res = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const SimpleBarcodeScannerPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
                if (res && res != "-1") widget.addNewProduct(res);

                break;
              }
          }
        }
      },
    );
  }
}
