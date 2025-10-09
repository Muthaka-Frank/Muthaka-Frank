import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return ListTile(
                leading: const Icon(Icons.cake_outlined),
                title: Text(item.cake.name),
                subtitle: Text('\$${item.cake.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => cart.updateQuantity(item.cake, (item.quantity - 1).clamp(1, 99)),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => cart.updateQuantity(item.cake, item.quantity + 1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => cart.removeCake(item.cake),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemCount: cart.items.length,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: cart.items.isEmpty ? null : () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Order placed!'),
                      content: const Text('Your delicious pastries are on the way.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );
                  cart.clear();
                },
                child: const Text('Checkout'),
              )
            ],
          ),
        )
      ],
    );
  }
}
