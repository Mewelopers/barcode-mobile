import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../common/jkp_colors.dart';

class BottomNavBar extends StatefulWidget {
  final Function _addListItem;

  const BottomNavBar({super.key, required Function addListItem}) : _addListItem = addListItem;

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
              widget._addListItem(null);
              break;
            }
          case 2:
            {
              var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ));

              widget._addListItem(res);

              break;
            }
        }
      },
    );
  }
}
