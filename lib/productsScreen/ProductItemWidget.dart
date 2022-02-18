import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/product_provider.dart';

import '../providers/cart_provider.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightGreen),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print('add to cart is clicked');
                cart.addCartItem(product.id);
              },
            ),
            leading: Consumer<Product>(
              builder: (context, prod, child) => IconButton(
                icon: prod.isFavorite
                    ? Icon(Icons.favorite, color: Colors.amber)
                    : Icon(Icons.favorite),
                onPressed: () {
                  product.toggleFavorite();
                },
              ),
            ),
            backgroundColor: Colors.black45,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
