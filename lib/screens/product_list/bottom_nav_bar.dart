import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../common/jkp_colors.dart';
import '../product_addition/product_addition.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
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
        switch (option) {
          case 0:
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductAddition(),
                  ));
              break;
            }
          case 2:
            {
              var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ));

              break;
            }
        }
      },
    );
  }
}
