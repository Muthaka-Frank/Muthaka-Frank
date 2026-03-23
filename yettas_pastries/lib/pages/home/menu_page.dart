import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/catalog_controller.dart';
import '../../state/cart_controller.dart';
import '../../theme.dart';
import '../../models/cake.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CatalogController catalog = context.watch<CatalogController>();
    if (!catalog.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    final List<Cake> cakes = catalog.cakes;
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100, top: 8),
      itemCount: cakes.length,
      itemBuilder: (BuildContext context, int index) {
        final Cake cake = cakes[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: cake.accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.cake, color: cake.accentColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cake.name, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text(cake.description, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      Text('\u00A4${cake.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.read<CartController>().addCake(cake),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dominant),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
