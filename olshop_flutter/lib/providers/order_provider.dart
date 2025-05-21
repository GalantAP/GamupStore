import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(List<Product> products, double total) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        products: products,
        totalAmount: total,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
