import 'package:flutter/material.dart';
import 'package:shopping/CartScreen/CartWidget.dart';
import 'package:shopping/productsScreen/ProductsWidget.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/providers/products_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart())
      ],
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Color(0x344955),
          primarySwatch: Colors.green,
          accentColor: Color(0xf9aa33),
        ),
        routes: {
          '/': (context) => RootWidget(),
          CartWidget.routeName: (context) => CartWidget()
        },
      )));
}

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductsWidget();
  }
}
