import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 76, 79, 146),
          title: const Text('JKP',
              style: TextStyle(color: Color.fromARGB(255, 135, 223, 154))),
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined),
            onPressed: () {},
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
          child: Center(
            child: Container(
              width: 200,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Zakupy spożywcze',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.image_search),
              label: "skanuj kod kreskowy",
            ),
          ],
        ),
      ),
    );
  }
}
