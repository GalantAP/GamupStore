import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final Product product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return ListTile(
      leading: Image.network(product.imageUrl, width: 50, fit: BoxFit.cover),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          cart.removeItem(product.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Removed from cart')),
          );
        },
      ),
    );
  }
}
