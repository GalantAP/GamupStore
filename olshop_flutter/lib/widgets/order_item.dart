import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Format tanggal dan waktu dari order
    final dateFormatted = DateFormat.yMMMd().add_jm().format(order.dateTime);

    // Format mata uang ke dalam Rupiah
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return ExpansionTile(
      title: Text(
        currencyFormat.format(order.totalAmount),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        dateFormatted,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
      children: order.products
          .map(
            (prod) => ListTile(
              title: Text(
                prod.name,
                style: const TextStyle(fontSize: 15),
              ),
              trailing: Text(
                currencyFormat.format(prod.price),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
