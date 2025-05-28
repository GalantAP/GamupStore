import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Map<String, bool> _selectedItems = {};
  final TextEditingController _addressController = TextEditingController();

  String _selectedPayment = 'dana';

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'value': 'dana',
      'label': 'DANA',
      'icon': 'assets/images/dana_icon.png',
    },
    {
      'value': 'seabank',
      'label': 'SeaBank',
      'icon': 'assets/images/seabank_icon.png',
    },
    {
      'value': 'gopay',
      'label': 'GoPay',
      'icon': 'assets/images/gopay_icon.png',
    },
    {
      'value': 'brimo',
      'label': 'BRImo',
      'icon': 'assets/images/brimo_icon.png',
    },
    {
      'value': 'bni',
      'label': 'BNI',
      'icon': 'assets/images/bni_icon.png',
    },
    {
      'value': 'ovo',
      'label': 'OVO',
      'icon': 'assets/images/ovo_icon.png',
    },
    {
      'value': 'otherbank',
      'label': 'Bank Lainnya',
      'icon': 'assets/images/bank_icon.png',
    },
  ];

  Future<void> _placeOrder(BuildContext context) async {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final selectedItems = cart.items.entries
        .where((entry) => _selectedItems[entry.key] == true)
        .map((entry) => entry.value)
        .toList();

    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alamat pengiriman harus diisi!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih minimal satu item!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final totalAmount = selectedItems.fold<double>(
      0,
      (sum, item) => sum + item.price,
    );

    // === PEMANGGILAN BARU SESUAI PROVIDER ===
    orderProvider.addOrder(
      products: selectedItems,
      total: totalAmount,
      provinsi: '', // isi sesuai jika ingin bertingkat (provinsi/kota)
      kota: '',
      kecamatan: '',
      alamatDetail: _addressController.text.trim(),
      metodePembayaran: _selectedPayment,
    );
    // ========================================

    cart.clear();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Berhasil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 60, color: Colors.green.shade600),
            const SizedBox(height: 12),
            const Text('Pesanan berhasil dibuat!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/order-history', (route) => false);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final primaryBlue = Colors.indigo.shade900;
    final lighterBlue = Colors.indigo.shade700;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

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
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Alamat Pengiriman
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                shadowColor: primaryBlue.withAlpha((0.18 * 255).round()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alamat Pengiriman",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan alamat lengkap...',
                          prefixIcon: Icon(Icons.location_on_rounded, color: primaryBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 1),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                        maxLines: 2,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Metode Pembayaran
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                shadowColor: primaryBlue.withAlpha((0.18 * 255).round()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metode Pembayaran",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedPayment,
                        items: _paymentMethods.map((method) {
                          return DropdownMenuItem<String>(
                            value: method['value'],
                            child: Row(
                              children: [
                                Image.asset(
                                  method['icon'],
                                  width: 28,
                                  height: 28,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  method['label'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPayment = value!;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 1),
                          ),
                        ),
                        icon: Icon(Icons.arrow_drop_down_rounded, color: lighterBlue, size: 28),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Pilihan Item/Barang
              Expanded(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  shadowColor: primaryBlue.withAlpha((0.25 * 255).round()),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Barang Yang Akan Di-Checkout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: cart.items.isEmpty
                              ? Center(
                                  child: Text(
                                    'Tidak ada barang di keranjang',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: cart.items.length,
                                  itemBuilder: (ctx, index) {
                                    final entry = cart.items.entries.elementAt(index);
                                    final product = entry.value;
                                    final isSelected = _selectedItems[entry.key] ?? true;

                                    return Container(
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? lighterBlue.withAlpha((0.1 * 255).round())
                                            : Colors.transparent,
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected ? primaryBlue : Colors.grey.shade700,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Harga: ${currencyFormat.format(product.price)}\nJumlah: 1',
                                          style: TextStyle(
                                            fontSize: 13,
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
              const SizedBox(height: 18),
              // Total & Buat Pesanan
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                shadowColor: primaryBlue.withAlpha((0.25 * 255).round()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: [
                      Text(
                        'Total Bayar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currencyFormat.format(totalAmount),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () => _placeOrder(context),
                icon: const Icon(Icons.check_circle_outline, size: 26, color: Colors.white),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Buat Pesanan',
                    style: TextStyle(
                      fontSize: 18,
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
                  shadowColor: primaryBlue.withAlpha((0.5 * 255).round()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
