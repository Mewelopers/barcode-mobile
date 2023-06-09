import 'package:flutter/material.dart';
import 'MyCheckbox.dart';

class ProductTile extends StatelessWidget {
  ProductTile({super.key, this.productName=''});
  String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 70,
          right: 70,
          top: 15
      ),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const MyCheckbox(),
          SizedBox(
            width: 180,
            child: Text(productName,
              style: const TextStyle(fontSize: 16)
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            alignment: Alignment.centerRight,
            visualDensity: const VisualDensity(horizontal: -4)
          )
        ],
      ),
    );
  }
}

class ProductTileWithInfo extends StatelessWidget {
  ProductTileWithInfo({super.key, this.productName=''});
  String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 70,
          right: 70,
          top: 15
      ),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const MyCheckbox(),
          SizedBox(
            width: 140,
            child: Text(productName,
                style: const TextStyle(fontSize: 16)
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye_outlined),
            alignment: Alignment.centerRight,
              visualDensity: const VisualDensity(horizontal: -4)
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            alignment: Alignment.centerRight,
            visualDensity: const VisualDensity(horizontal: -4)
          )
        ],
      ),
    );
  }
}
