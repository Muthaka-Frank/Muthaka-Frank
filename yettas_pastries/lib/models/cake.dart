import 'package:flutter/material.dart';

class Cake {
  final String id;
  final String name;
  final String description;
  final double price;
  final Color accentColor;

  const Cake({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.accentColor,
  });
}
