import 'package:flutter/material.dart';
import '../models/cake.dart';

class CatalogController extends ChangeNotifier {
  List<Cake> _cakes = const [];
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  List<Cake> get cakes => List.unmodifiable(_cakes);

  Future<void> initialize() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _cakes = const [
      Cake(
        id: 'chocolate_fudge',
        name: 'Chocolate Fudge',
        description: 'Rich, moist, and decadent chocolate layers.',
        price: 24.99,
        accentColor: Color(0xFF5D4037),
      ),
      Cake(
        id: 'vanilla_bean',
        name: 'Vanilla Bean',
        description: 'Classic Madagascar vanilla with silky buttercream.',
        price: 19.99,
        accentColor: Color(0xFFFFF3E0),
      ),
      Cake(
        id: 'red_velvet',
        name: 'Red Velvet',
        description: 'Velvety crumb with light cream cheese frosting.',
        price: 22.99,
        accentColor: Color(0xFFD32F2F),
      ),
      Cake(
        id: 'lemon_zest',
        name: 'Lemon Zest',
        description: 'Bright lemon sponge with tangy curd filling.',
        price: 21.49,
        accentColor: Color(0xFFFFF59D),
      ),
      Cake(
        id: 'strawberry_shortcake',
        name: 'Strawberry Shortcake',
        description: 'Airy vanilla with strawberries and whipped cream.',
        price: 23.49,
        accentColor: Color(0xFFFFCDD2),
      ),
      Cake(
        id: 'black_forest',
        name: 'Black Forest',
        description: 'Chocolate, cherries, and light whipped cream.',
        price: 25.99,
        accentColor: Color(0xFF3E2723),
      ),
      Cake(
        id: 'carrot_cake',
        name: 'Carrot Cake',
        description: 'Spiced layers with tangy cream cheese frosting.',
        price: 20.99,
        accentColor: Color(0xFFFFE0B2),
      ),
    ];
    _isInitialized = true;
    notifyListeners();
  }
}
