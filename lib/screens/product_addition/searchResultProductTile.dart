import 'package:flutter/material.dart';
import 'package:barcode_mobile/models/product.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/jkp_colors.dart';
import '../../constants/jkp_constants.dart';

class SearchResultProductTile extends StatelessWidget {
  final Product product;
  final Function addNewProduct;

  const SearchResultProductTile({super.key, required this.product, required this.addNewProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 213, 206, 239),
          color: clrNeutral100,
          borderRadius: BorderRadius.circular(40),
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(150, 71, 123, 143),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FloatingActionButton.small(
                      heroTag: "AddNewProduct",
                      backgroundColor: clrNeutral900,
                      child: const Icon(Icons.add, color: clrNeutral100),
                      onPressed: () {
                        addNewProduct(product.barcode, navBackCount: 2);
                      },
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        product.name,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        selectionColor: clrNeutral900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              product.thumbnailUrl == null
                  ? SvgPicture.asset(
                      'assets/images/not_found.svg',
                      height: 100,
                    )
                  : Image.network(
                      apiUrl + product.thumbnailUrl!,
                      height: 100,
                      loadingBuilder: (context, child, progress) {
                        return progress == null ? child : const CircularProgressIndicator();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
