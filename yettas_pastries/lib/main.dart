import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'state/auth_controller.dart';
import 'state/cart_controller.dart';
import 'state/catalog_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()..initialize()),
        ChangeNotifierProvider(create: (_) => CatalogController()..initialize()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: const YettasPastriesApp(),
    ),
  );
}
