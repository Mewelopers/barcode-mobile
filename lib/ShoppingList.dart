import 'package:flutter/material.dart';
import 'MyCheckbox.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 79, 146),
          title: const Text('JKP',
              style: TextStyle(color: Color.fromARGB(255, 135, 223, 154))),
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left_outlined),
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
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 60,
                  right: 60,
                  top: 20
                ),
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
              Container(
                margin: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                    top: 20
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const MyCheckbox(),
                    const Text('ProductName',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye_outlined)
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete)
                    )
                  ],
                ),
              ),
            ]
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
