import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// class CartItem {
//   String _quantity;

//   CartItem(this._quantity);
// }

class Cart extends ChangeNotifier {
  Map<String, int> _cartItems = {};

  Map<String, int> get cartItems {
    return _cartItems;
  }

  void addCartItem(String productId) {
    if (_cartItems.containsKey(productId))
      _cartItems.update(productId, (value) => value + 1);
    else
      _cartItems.putIfAbsent(productId, () => 1);
    print(_cartItems);
    notifyListeners();
  }
}
