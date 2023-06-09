import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String TOKEN =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IkQzRUU4QjAzNDRBQTc5QzdDMzJGMjA5MUU3Mzg1NDA4IiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2ODUzMDQ5ODAsImV4cCI6MTY4NTY2NDk4MCwiaXNzIjoiaHR0cHM6Ly95ZXJtYWtvdmljaC5jb20vaWRlbnRpdHkiLCJhdWQiOiJqa3AtYXBpIiwiY2xpZW50X2lkIjoiamtwIiwic3ViIjoiN2FiZmNkZWQtYTc5Zi00NDc1LWE2YzQtYWQ3YmQ1M2I2MjhlIiwiYXV0aF90aW1lIjoxNjg1Mjk5NTgxLCJpZHAiOiJsb2NhbCIsInJvbGUiOiJjbGllbnQiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJwYXRyeWtzIiwibmFtZSI6InBhdHJ5a3MiLCJlbWFpbCI6InJvb216b29tQHdwLnBsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJqdGkiOiJDRTI0MDU0QjE2NjM2MjFGNjJDQzFENzIwRkI5QTkwNSIsInNpZCI6IjJBMzM5MTI0RjAwNjE0OEIxNDE4OEU4MzhDQUMwRUVEIiwiaWF0IjoxNjg1MzA0OTgwLCJzY29wZSI6WyJvcGVuaWQiLCJwcm9maWxlIiwiamtwLWFwaSIsImVtYWlsIiwicm9sZXMiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.4r4VtMbdPrpp_lE1mvFHQelHoGZ_ANq8CffQg69XzLmFH69ZM-NVXRo_7wIznoyIMyzNZvGpVs1WKr87Wjb6GLM4e5YMaIxFmKT3YeoxHuq5P-LB8tmbGFXidIau_iSpVlLe9j-kH3sV8FFjhBjUlEHmvXvZT3FyYxv3tUEphx08110q5zlZzoNiZGd9gWHRooAO7NOWs547BF0Zp9YEbKhDy1R-8avOAidhbAQ7TwL_PaCLe-O8IlYLjL_Q-upJtltXe9QYuAQ9xX3SVavydPdb5x5p53qC5AJfYOPy0wqRsHTMq1xlO2HhDGcMFzYHKWuOXiz_pAO2gXJhsc24MQ';

Future<List<ShoppingList>> fetchLists() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/lists'), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer $TOKEN',
  });
  if (response.statusCode == 200) {
    final List<dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));
    final List<ShoppingList> shoppingLists = [];

    for (var item in responseData) {
      shoppingLists.add(ShoppingList.fromJSON(item));
    }
    return shoppingLists;
  } else {
    throw Exception('Failed to load shopping lists');
  }
}

Future<void> sendDeleteQuery(int id) async {
  final response = await http.delete(
    Uri.parse('http://10.0.2.2:8000/api/v1/lists/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN',
    },
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to delete list.');
  }
}

Future<ShoppingList> sendPostQuery(String listTitle) async {
  final response =
      await http.post(Uri.parse('http://10.0.2.2:8000/api/v1/lists'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $TOKEN',
          },
          body: jsonEncode({'list_title': listTitle}));

  if (response.statusCode == 200) {
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    final newShoppingList = ShoppingList.fromJSON(responseData);

    return newShoppingList;
  } else {
    throw Exception('Failed to add list.');
  }
}

Future<ShoppingList> sendPutQuery(String listTitle, int id) async {
  final response =
      await http.put(Uri.parse('http://10.0.2.2:8000/api/v1/lists/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $TOKEN',
          },
          body: jsonEncode({'list_title': listTitle}));

  if (response.statusCode == 200) {
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    final newShoppingList = ShoppingList.fromJSON(responseData);

    return newShoppingList;
  } else {
    throw Exception('Failed to edit list.');
  }
}

class ShoppingList {
  final String ownerUserId;
  final String listTitle;
  final String createdAt;
  final String updatedAt;
  final int id;

  const ShoppingList(
      {required this.ownerUserId,
      required this.listTitle,
      required this.createdAt,
      required this.updatedAt,
      required this.id});

  factory ShoppingList.fromJSON(Map<String, dynamic> json) {
    return ShoppingList(
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        ownerUserId: json['owner_user_id'],
        listTitle: json['list_title'],
        id: json['id']);
  }
}

class ListOfLists extends StatefulWidget {
  const ListOfLists({super.key});

  @override
  _ListOfListsState createState() => _ListOfListsState();
}

class _ListOfListsState extends State<ListOfLists> {
  late Future<List<ShoppingList>> futureShoppingLists;

  @override
  void initState() {
    super.initState();
    futureShoppingLists = fetchLists();
  }

  void handleListDelete(int id) async {
    sendDeleteQuery(id);
    List<ShoppingList> shoppingLists = await futureShoppingLists;
    int deletedListIndex = shoppingLists.indexWhere((list) => list.id == id);
    shoppingLists.removeAt(deletedListIndex);
    setState(() {
      futureShoppingLists = Future.value(shoppingLists);
    });
  }

  void handleListAdd(String listTitle) async {
    ShoppingList newShoppingList = await sendPostQuery(listTitle);
    List<ShoppingList> shoppingLists = await futureShoppingLists;
    shoppingLists.add(newShoppingList);
    setState(() {
      futureShoppingLists = Future.value(shoppingLists);
    });
  }

  void handleListEdit(String listTitle, int id) async {
    List<ShoppingList> shoppingLists = await futureShoppingLists;
    int editedListIndex = shoppingLists.indexWhere((list) => list.id == id);
    ShoppingList newShoppingList = await sendPutQuery(listTitle, id);
    shoppingLists[editedListIndex] = newShoppingList;
    setState(() {
      futureShoppingLists = Future.value(shoppingLists);
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
            child: FutureBuilder<List<ShoppingList>>(
                future: futureShoppingLists,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ShoppingList>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String name = snapshot.data![index].listTitle;
                        int id = snapshot.data![index].id;
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 40, right: 40, left: 40),
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
                                      editList(context, id, name);
                                    },
                                    color: Colors.black,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      deleteListItem(context, id, name);
                                    },
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Brak dostepnych danych'));
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
