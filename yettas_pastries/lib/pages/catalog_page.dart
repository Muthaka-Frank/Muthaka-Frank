import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/catalog_controller.dart';
import '../state/cart_controller.dart';
import '../theme/app_theme.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Explore our flavors',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final cake = catalog.cakes[index];
                return _CakeCard(cakeName: cake.name, description: cake.description, price: cake.price, onAdd: () {
                  context.read<CartController>().addCake(cake);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${cake.name} added to cart'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: kDominantColor,
                      duration: const Duration(milliseconds: 900),
                    ),
                  );
                });
              },
              childCount: catalog.cakes.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _CakeCard extends StatelessWidget {
  final String cakeName;
  final String description;
  final double price;
  final VoidCallback onAdd;

  const _CakeCard({
    required this.cakeName,
    required this.description,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onAdd,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kDominantColor.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.cake, size: 48, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                cakeName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton.filledTonal(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
