import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    final blue = Colors.blue.shade700;
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: blue,
        title: const Text(
          'Your Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SafeArea(
        child: cart.itemCount == 0
            ? Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 20,
                    color: blue.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      itemCount: cart.itemCount,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (ctx, i) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                        shadowColor: blue.withOpacity(0.3),
                        child: CartItem(product: cartItems[i]),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        elevation: 6,
                        shadowColor: blue.withOpacity(0.4),
                      ),
                      onPressed: cart.itemCount == 0
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                _createRoute(const CheckoutScreen()),
                              );
                            },
                      child: Text(
                        'Checkout (\$${cart.totalAmount.toStringAsFixed(2)})',
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
