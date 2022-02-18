import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart_provider.dart';

import 'package:shopping/providers/products_provider.dart';

class CartWidget extends StatelessWidget {
  static const String routeName = '/cart';
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Consumer2<Cart, Products>(
          builder: (context, currCart, currProducts, child) => Container(
              child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Total : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Chip(label: Text(cal(currCart, currProducts).toString())),
                ],
              ),
              Expanded(
                  child: ListView(children: [
                ...currCart.cartItems.entries
                    .map((e) => CartItemWidget(e))
                    .toList()
              ]))
            ],
          )),
        ),
      ),
    );
  }

  double cal(Cart cart, Products products) {
    var cartItems = cart.cartItems;
    var productsItems = products.productList;
    double result = 0.0;
    cartItems.forEach((key, value) {
      result += productsItems.firstWhere((element) => element.id == key).price *
          value;
    });
    return result;
  }
}

class CartItemWidget extends StatelessWidget {
  CartItemWidget(
    this.e, {
    Key? key,
  }) : super(key: key);

  MapEntry<String, int> e;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          return Future<bool>(
            () => false,
          );
        } else if (direction == DismissDirection.endToStart)
          return Future<bool>(
            () => true,
          );
        else
          return Future<bool>(
            () => false,
          );
      },
      key: Key(e.key),
      background: Container(color: Colors.green),
      secondaryBackground: Container(color: Colors.red),
      child: ListTile(
        leading: CircleAvatar(child: Text(e.key)),
        trailing: Text(e.value.toString()),
      ),
    );
  }
}
