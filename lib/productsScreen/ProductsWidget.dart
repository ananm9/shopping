import 'package:flutter/material.dart';
import 'package:shopping/CartScreen/CartWidget.dart';
import 'package:shopping/productsScreen/ProductItemWidget.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products_provider.dart';

enum ShowMode { ShowAll, FavoriteOnly }

class ProductsWidget extends StatefulWidget {
  static const String routeName = '/ProductsWidget';
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  var isWantFavorite = false;
  @override
  Widget build(BuildContext context) {
    var productsList = Provider.of<Products>(context).productList;
    if (isWantFavorite)
      productsList =
          productsList.where((element) => element.isFavorite).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isWantFavorite = !isWantFavorite;
                  });
                },
                icon: Icon(Icons.favorite_outline)),
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == ShowMode.ShowAll)
                    isWantFavorite = false;
                  else
                    isWantFavorite = true;
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Only Favorite'),
                  value: ShowMode.FavoriteOnly,
                ),
                PopupMenuItem(child: Text('Show All'), value: ShowMode.ShowAll)
              ],
            )
          ],
        ),
        drawer: myDrawer(),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: GridView.builder(
              padding: EdgeInsets.all(5),
              itemCount: productsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: productsList[index],
                  child: ProductItemWidget(),
                );
              }),
        ));
  }
}

class myDrawer extends StatelessWidget {
  const myDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shopping Cart'),
            onTap: () {
              Navigator.of(context).pushNamed(CartWidget.routeName);
            },
          )
        ],
      ),
    );
  }
}
