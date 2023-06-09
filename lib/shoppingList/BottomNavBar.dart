import 'package:barcode_mobile/ProductAddition.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int option) { setState(() {
        switch (option) {
          case 0: {
            break;
          }
          case 1: {
            runApp(const ProductAddition());
            break;
          }
          case 2: {
            break;
          }
        }
      });},
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "dodaj produkt",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "wyszukaj produkt",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.barcode_reader),
          label: "skanuj kod kreskowy",
        ),
      ],
    );
  }
}