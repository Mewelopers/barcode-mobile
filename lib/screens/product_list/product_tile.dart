import 'package:barcode_mobile/extensions/string_extensions.dart';
import 'package:barcode_mobile/screens/product_view/product_view.dart';
import 'package:flutter/material.dart';

import '../../common/jkp_colors.dart';
import '../../models/shopping_list_item.dart';

class ProductTile extends StatelessWidget {
  final Function _deleteListItem;
  final Function _editListItem;

  const ProductTile(
      {super.key, required ShoppingListItem listItem, required Function editListItem, required Function deleteListItem})
      : _editListItem = editListItem,
        _deleteListItem = deleteListItem,
        _listItem = listItem;

  final ShoppingListItem _listItem;

  void showDeletePopup(BuildContext context) {
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
          const TextSpan(text: 'Czy na pewno chcesz usunąć ten produkt:\n'),
          TextSpan(text: _listItem.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 2)),
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
                    _deleteListItem(_listItem.id);
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

  void showEditPopup(BuildContext context) {
    String newListName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nowa nazwa produktu'),
          backgroundColor: clrAccent200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: TextField(
              decoration: InputDecoration(hintText: _listItem.name),
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
                  child: const Text('Zatwierdź', style: TextStyle(color: clrNeutral900)),
                  onPressed: () {
                    _editListItem(_listItem.id, newListName, _listItem.productBarcode);
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          padding: const EdgeInsets.only(left: 18),
          decoration: BoxDecoration(
            color: clrNeutral300,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _listItem.name.capitalize(),
                  style: const TextStyle(color: clrNeutral900, fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  if (_listItem.productBarcode != null) const Icon(Icons.remove_red_eye_outlined, color: clrNeutral900),
                  Container(
                    decoration:
                        const BoxDecoration(color: clrAccent300, borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: clrAccent500, borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: IconButton(
                            padding: const EdgeInsets.all(16),
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showEditPopup(context);
                            },
                            color: clrNeutral900,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDeletePopup(context);
                          },
                          color: clrNeutral900,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          if (_listItem.productBarcode == null) {
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductView(listItem: _listItem),
            ),
          );
        });
  }
}
