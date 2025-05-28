import 'product.dart';

class Order {
  final String id;
  final List<Product> products;
  final double totalAmount;
  final DateTime dateTime;

  // Tambahan:
  final String alamatProvinsi;
  final String alamatKota;
  final String alamatKecamatan;
  final String alamatDetail;
  final String metodePembayaran;

  Order({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.dateTime,
    required this.alamatProvinsi,
    required this.alamatKota,
    required this.alamatKecamatan,
    required this.alamatDetail,
    required this.metodePembayaran,
  });
}
