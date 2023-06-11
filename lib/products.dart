import 'package:flutter/material.dart';
class Product extends StatelessWidget{
  @override

  const Product();
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(25),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 213, 206, 239),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  children: <Widget>[
                    FloatingActionButton.small(
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.add,
                      color: Color.fromARGB(255, 213, 206, 239)),
                      onPressed: () {},
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Majonez to jest i tyle',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      selectionColor: Colors.black,
                    ),
                  ]
              )
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: const Image(
                  image: AssetImage('assets/images/majonez.png'),
                  height: 160,
              ),
            ),
          ]
        )
      ),
    );
  }
}