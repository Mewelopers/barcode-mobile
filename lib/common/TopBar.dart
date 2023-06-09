import 'package:flutter/material.dart';
import 'package:barcode_mobile/main.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar({super.key, this.backButtonDestination = const MyApp()});
  Widget backButtonDestination;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 76, 79, 146),
      title: const Text('JKP',
        style: TextStyle(color: Color.fromARGB(255, 135, 223, 154))),
      leading: IconButton(
        icon: const Icon(Icons.arrow_circle_left_outlined),
        onPressed: () => {runApp(backButtonDestination)}
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
