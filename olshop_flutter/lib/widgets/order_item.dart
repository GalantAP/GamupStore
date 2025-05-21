import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat.yMMMd().add_jm().format(order.dateTime);

    return ExpansionTile(
      title: Text('Order \$${order.totalAmount.toStringAsFixed(2)}'),
      subtitle: Text(dateFormatted),
      children: order.products
          .map((prod) => ListTile(
                title: Text(prod.name),
                trailing: Text('\$${prod.price.toStringAsFixed(2)}'),
              ))
          .toList(),
    );
  }
}
