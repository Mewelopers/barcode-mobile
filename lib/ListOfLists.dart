import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListOfLists extends StatefulWidget {
  const ListOfLists({super.key});

  @override
  _ListOfListsState createState() => _ListOfListsState();
}

class _ListOfListsState extends State<ListOfLists> {
  List<Map<String, dynamic>> jsonList = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  void loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/exampleList.json');
    setState(() {
      jsonList = jsonDecode(jsonString)['lists'].cast<Map<String, dynamic>>();
    });
  }

  void editList(BuildContext context, int index, String previousName) {
    const String EDIT_LIST_TITLE = 'Edycja nazwy listy';
    String newListName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(EDIT_LIST_TITLE),
          backgroundColor: const Color.fromARGB(255, 244, 207, 113),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: TextField(
              decoration: InputDecoration(hintText: previousName),
              onChanged: (value) {
                newListName = value;
              },
              textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          actionsPadding:
              const EdgeInsets.only(top: 10, bottom: 20, left: 40, right: 40),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor:
                          const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Anuluj',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor:
                          const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Zatwierdź',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onPressed: () {
                    setState(() {
                      jsonList.elementAt(index)['name'] = newListName;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void deleteListItem(BuildContext context, int index, String name) {
    String deletionString = 'Czy na pewno chcesz usunąć listę zakupów $name ?';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 244, 207, 113),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Text(deletionString, textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          actionsPadding:
              const EdgeInsets.only(top: 10, bottom: 20, left: 40, right: 40),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor:
                          const Color.fromARGB(255, 135, 223, 154)),
                  child:
                      const Text('Nie', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor:
                          const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Tak',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onPressed: () {
                    setState(() {
                      jsonList.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void addList(BuildContext context) {
    const String ADD_NEW_LIST_TITLE = 'Dodawanie nowej listy';
    String newListName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(ADD_NEW_LIST_TITLE),
          backgroundColor: const Color.fromARGB(255, 244, 207, 113),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: TextField(
              onChanged: (value) {
                newListName = value;
              },
              textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          actionsPadding:
              const EdgeInsets.only(top: 10, bottom: 20, left: 40, right: 40),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor:
                          const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Anuluj',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor:
                          const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Dodaj listę',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onPressed: () {
                    if (newListName.isNotEmpty) {
                      setState(() {
                        jsonList.add(
                            {'id': jsonList.length + 1, 'name': newListName});
                      });
                      Navigator.of(context).pop();
                      newListName = '';
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 76, 79, 146),
          title: const Text(
            'JKP',
            style: TextStyle(color: Color.fromARGB(255, 135, 223, 154)),
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
            child: ListView.builder(
              itemCount: jsonList.length,
              itemBuilder: (BuildContext context, int index) {
                String name = jsonList[index]['name'];
                return Container(
                  margin: const EdgeInsets.only(top: 40, right: 40, left: 40),
                  padding: const EdgeInsets.only(
                      top: 4, right: 5, bottom: 4, left: 30),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 135, 223, 154),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              editList(context, index, name);
                            },
                            color: Colors.black,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteListItem(context, index, name);
                            },
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButton: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(150, 120, 205, 240),
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addList(context);
                  },
                  color: const Color.fromARGB(150, 120, 205, 240),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
