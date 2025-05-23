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
        const SnackBar(content: Text('Please select at least one item!')),
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
      const SnackBar(content: Text('Order placed successfully!')),
    );

    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final blue = Colors.blue.shade700;

    if (_selectedItems.isEmpty) {
      for (var key in cart.items.keys) {
        _selectedItems[key] = true;
      }
    }

    final totalAmount = cart.items.entries
        .where((entry) => _selectedItems[entry.key] == true)
        .fold<double>(0, (sum, entry) => sum + entry.value.price);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: blue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: blue.withOpacity(0.3),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: ListView(
                      children: [
                        Text(
                          'Select items to checkout',
                          style: TextStyle(
                            fontSize: 20,
                            color: blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...cart.items.entries.map((entry) {
                          final product = entry.value;
                          final isSelected = _selectedItems[entry.key] ?? true;

                          return CheckboxListTile(
                            value: isSelected,
                            onChanged: (val) {
                              setState(() {
                                _selectedItems[entry.key] = val ?? false;
                              });
                            },
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                                'Price: Rp ${product.price.toStringAsFixed(2)}\nQuantity: 1'),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: blue.withOpacity(0.3),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 20,
                          color: blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Rp ${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _placeOrder(context),
                icon: const Icon(Icons.check_circle_outline, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white, // teks & icon jadi putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: blue.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
