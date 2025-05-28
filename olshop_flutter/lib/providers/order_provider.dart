import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder({
    required List<Product> products,
    required double total,
    required String provinsi,
    required String kota,
    required String kecamatan,
    required String alamatDetail,
    required String metodePembayaran,
  }) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        products: products,
        totalAmount: total,
        dateTime: DateTime.now(),
        alamatProvinsi: provinsi,
        alamatKota: kota,
        alamatKecamatan: kecamatan,
        alamatDetail: alamatDetail,
        metodePembayaran: metodePembayaran,
      ),
    );
    notifyListeners();
  }
}
