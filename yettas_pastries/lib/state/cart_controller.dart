import 'package:flutter/material.dart';
import '../models/cake.dart';

class CartItem {
  final Cake cake;
  int quantity;
  CartItem({required this.cake, this.quantity = 1});

  double get totalPrice => cake.price * quantity;
}

class CartController extends ChangeNotifier {
  final Map<String, CartItem> _itemsByCakeId = <String, CartItem>{};

  List<CartItem> get items => _itemsByCakeId.values.toList(growable: false);
  int get totalQuantity => _itemsByCakeId.values.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _itemsByCakeId.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addCake(Cake cake) {
    final CartItem? existing = _itemsByCakeId[cake.id];
    if (existing != null) {
      existing.quantity += 1;
    } else {
      _itemsByCakeId[cake.id] = CartItem(cake: cake, quantity: 1);
    }
    notifyListeners();
  }

  void updateQuantity(Cake cake, int quantity) {
    final int clamped = quantity.clamp(1, 99);
    final CartItem? existing = _itemsByCakeId[cake.id];
    if (existing == null) return;
    existing.quantity = clamped;
    notifyListeners();
  }

  void decrementCake(Cake cake) {
    final CartItem? existing = _itemsByCakeId[cake.id];
    if (existing == null) return;
    if (existing.quantity > 1) {
      existing.quantity -= 1;
    } else {
      _itemsByCakeId.remove(cake.id);
    }
    notifyListeners();
  }

  void removeCake(Cake cake) {
    _itemsByCakeId.remove(cake.id);
    notifyListeners();
  }

  void clear() {
    _itemsByCakeId.clear();
    notifyListeners();
  }
}
