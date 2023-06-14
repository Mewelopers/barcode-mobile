import 'package:flutter/material.dart';
import 'package:barcode_mobile/models/product.dart';
import '../../constants/jkp_constants.dart';

class SearchResultProductTile extends StatelessWidget{
  final Product product;
  final Function addProductFromList;
  final Function addNewProduct;

  const SearchResultProductTile({super.key, required this.product, required this.addNewProduct, required this.addProductFromList});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10
      ),
      child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 213, 206, 239),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        children: <Widget>[
                          FloatingActionButton.small(
                            backgroundColor: Colors.black,
                            child: const Icon(Icons.add,
                                color: Color.fromARGB(255, 213, 206, 239)),
                            onPressed: () {
                              addProductFromList(product.name, product.barcode);
                              Navigator.pop(context);
                            }
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              selectionColor: Colors.black,
                            )
                          )
                        ]
                    )
                ),
                Image.network(
                  apiUrl + product.thumbnailUrl,
                  height: MediaQuery.of(context).size.width * 0.4,
                )
              ]
          )
      ),
    );
  }
}