import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Map<String, bool> _selectedItems = {};

  void _placeOrder(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final selectedItems = cart.items.entries
        .where((entry) => _selectedItems[entry.key] == true)
        .map((entry) => entry.value)
        .toList();

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one item!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final totalAmount = selectedItems.fold<double>(
      0,
      (sum, item) => sum + item.price,
    );

    orderProvider.addOrder(selectedItems, totalAmount);
    cart.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully!'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pushNamedAndRemoveUntil(context, '/order-history', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final primaryBlue = Colors.indigo.shade900;
    final lighterBlue = Colors.indigo.shade700;

    if (_selectedItems.isEmpty) {
      for (var key in cart.items.keys) {
        _selectedItems[key] = true;
      }
    }

    final totalAmount = cart.items.entries
        .where((entry) => _selectedItems[entry.key] == true)
        .fold<double>(0, (sum, entry) => sum + entry.value.price);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: primaryBlue.withAlpha((0.3 * 255).round()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select items to checkout',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (ctx, index) {
                              final entry = cart.items.entries.elementAt(index);
                              final product = entry.value;
                              final isSelected = _selectedItems[entry.key] ?? true;

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSelected ? lighterBlue.withAlpha((0.1 * 255).round()) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: CheckboxListTile(
                                  value: isSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedItems[entry.key] = val ?? false;
                                    });
                                  },
                                  title: Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? primaryBlue : Colors.grey.shade700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Price: Rp ${product.price.toStringAsFixed(2)}\nQuantity: 1',
                                    style: TextStyle(
                                      color: isSelected ? lighterBlue : Colors.grey.shade500,
                                    ),
                                  ),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: primaryBlue,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: primaryBlue.withAlpha((0.3 * 255).round()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Rp ${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _placeOrder(context),
                icon: const Icon(Icons.check_circle_outline, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 10,
                  shadowColor: primaryBlue.withAlpha((0.7 * 255).round()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
