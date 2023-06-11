import 'dart:async';

import 'package:barcode_mobile/extensions/string_extensions.dart';
import 'package:barcode_mobile/screens/product_list/product_list.dart';
import 'package:flutter/material.dart';

import '../../common/background.dart';
import '../../common/jkp_colors.dart';
import '../../common/nav_bar.dart';
import '../../di/injectable.dart';
import '../../models/shopping_list.dart';
import '../../services/list_of_lists_service.dart';

class ListOfLists extends StatefulWidget {
  const ListOfLists({super.key});

  @override
  ListOfListsState createState() => ListOfListsState();
}

class ListOfListsState extends State<ListOfLists> {
  late ListOfListsService _listOfListsService;
  late Future<List<ShoppingList>> _futureShoppingLists;

  @override
  void initState() {
    super.initState();
    _listOfListsService = getIt.get<ListOfListsService>();
    _futureShoppingLists = _listOfListsService.getLists();
  }

  void handleListDelete(int id) async {
    await _listOfListsService.deleteList(id);
    List<ShoppingList> shoppingLists = await _futureShoppingLists;
    int deletedListIndex = shoppingLists.indexWhere((list) => list.id == id);
    shoppingLists.removeAt(deletedListIndex);
    setState(() {
      _futureShoppingLists = Future.value(shoppingLists);
    });
  }

  void handleListAdd(String listTitle) async {
    ShoppingList newShoppingList = await _listOfListsService.createList(listTitle);
    List<ShoppingList> shoppingLists = await _futureShoppingLists;
    shoppingLists.add(newShoppingList);
    setState(() {
      _futureShoppingLists = Future.value(shoppingLists);
    });
  }

  void handleListEdit(String listTitle, int id) async {
    List<ShoppingList> shoppingLists = await _futureShoppingLists;
    int editedListIndex = shoppingLists.indexWhere((list) => list.id == id);
    ShoppingList newShoppingList = await _listOfListsService.editList(listTitle, id);
    shoppingLists[editedListIndex] = newShoppingList;
    setState(() {
      _futureShoppingLists = Future.value(shoppingLists);
    });
  }

  void editList(BuildContext context, int index, String previousName) {
    String newListName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edycja nazwy listy'),
          backgroundColor: const Color.fromARGB(255, 244, 207, 113),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: TextField(
              decoration: InputDecoration(hintText: previousName),
              onChanged: (value) {
                newListName = value;
              },
              textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          actionsPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Anuluj', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: const Color.fromARGB(255, 135, 223, 154)),
                  child: const Text('Zatwierdź',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onPressed: () {
                    handleListEdit(newListName, index);
                    newListName = '';
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
    var message = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 16,
          color: clrNeutral900,
        ),
        children: <TextSpan>[
          const TextSpan(text: 'Czy na pewno chcesz usunąć listę zakupów:\n'),
          TextSpan(text: name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 2)),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: clrAccent200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: message,
          contentPadding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          actionsPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: clrNeutral300),
                  child: const Text('Nie', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: clrNeutral300),
                  child: const Text('Tak',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onPressed: () {
                    handleListDelete(index);
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
    String newListName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodawanie nowej listy'),
          backgroundColor: clrAccent200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: TextField(
              onChanged: (value) {
                newListName = value;
              },
              textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          actionsPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: clrNeutral300),
                  child: const Text('Anuluj', style: TextStyle(color: clrNeutral900)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: clrNeutral300),
                  child: const Text('Dodaj listę',
                      style: TextStyle(
                        color: clrNeutral900,
                      )),
                  onPressed: () {
                    if (newListName.isNotEmpty) {
                      handleListAdd(newListName);
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
    return Scaffold(
      appBar: const NavBar(title: 'Twoje listy', showBackButton: false),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: background,
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: FutureBuilder<List<ShoppingList>>(
              future: _futureShoppingLists,
              builder: (BuildContext context, AsyncSnapshot<List<ShoppingList>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name = snapshot.data![index].listTitle;
                      int id = snapshot.data![index].id;
                      return InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 4),
                            padding: const EdgeInsets.only(left: 18),
                            decoration: BoxDecoration(
                              color: clrNeutral300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name.capitalize(),
                                  style:
                                      const TextStyle(color: clrNeutral900, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: clrAccent300, borderRadius: BorderRadius.all(Radius.circular(30))),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: clrAccent500, borderRadius: BorderRadius.all(Radius.circular(30))),
                                        child: IconButton(
                                          padding: const EdgeInsets.all(16),
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            editList(context, id, name);
                                          },
                                          color: clrNeutral900,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          deleteListItem(context, id, name);
                                        },
                                        color: clrNeutral900,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductList(shoppingList: snapshot.data![index]),
                              ),
                            );
                          });
                    },
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              }),
        ),
      ),
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: clrNeutral200,
          ),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: clrNeutral900,
            ),
            child: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  addList(context);
                },
                color: clrNeutral200,
              );
            }),
          ),
        ),
      ),
    );
  }
}
