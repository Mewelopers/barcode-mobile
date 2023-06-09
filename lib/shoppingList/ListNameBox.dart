import 'package:flutter/material.dart';

// In this class extract list name and put it in 'listName' from DB
class ListNameBox extends StatelessWidget {
  ListNameBox({super.key});
  String listName = 'Zakupy spożywcze';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 60,
          right: 60,
          top: 30
      ),
      height: 75,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Text(
          listName,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black
          )
        )
      )
    );
  }
}