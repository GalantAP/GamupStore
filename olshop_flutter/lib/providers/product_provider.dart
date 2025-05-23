import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Logitech G502 Hero Gaming Mouse',
      description: 'High precision gaming mouse with 16000 DPI sensor',
      price: 750000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/VqbcmM/2020/9/9/492f9ad7-6262-4837-aa44-5083c50d7b69.png',
      category: 'Mouse',
    ),
    Product(
      id: 'p2',
      name: 'Razer BlackWidow V3 Mechanical Keyboard',
      description: 'RGB mechanical keyboard with tactile switches',
      price: 1500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/product-1/2020/9/3/3393118/3393118_a5892eb4-5e54-4775-8c78-691b13a30a15_1040_1040',
      category: 'Keyboard',
    ),
    Product(
      id: 'p3',
      name: 'HyperX Cloud II Gaming Headset',
      description: '7.1 surround sound wired gaming headset',
      price: 1100000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/id-11134207-7r98z-lrqvuofz4r3b28',
      category: 'Headset',
    ),
    Product(
      id: 'p4',
      name: 'Secretlab Titan Gaming Chair',
      description: 'Ergonomic gaming chair with adjustable lumbar support',
      price: 7500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/VqbcmM/2024/12/19/2a8170a7-b566-4b4b-af7c-b67d8db0a26a.jpg',
      category: 'Chair',
    ),
    Product(
      id: 'p5',
      name: 'ASUS ROG Swift PG279Q Gaming Monitor',
      description: '27 inch 144Hz 2560x1440 IPS display monitor',
      price: 9000000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/VqbcmM/2023/6/16/aace93d3-e007-458d-9cd7-78cb9df9712f.jpg',
      category: 'Monitor',
    ),
    Product(
      id: 'p6',
      name: 'MSI GE66 Raider Gaming Laptop',
      description: 'Intel i7, RTX 3070, 16GB RAM high-performance laptop',
      price: 25000000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/OJWluG/2022/5/12/92fa46e3-463c-4431-a435-7a97de0559ab.jpg',
      category: 'Laptop',
    ),
    Product(
      id: 'p7',
      name: 'Xbox Wireless Controller',
      description: 'Wireless controller with vibration feedback',
      price: 850000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/id-11134207-7r98u-lvsw4x9c6igsb6',
      category: 'Controller',
    ),
    Product(
      id: 'p8',
      name: 'SteelSeries Apex Pro Mechanical Keyboard',
      description: 'Adjustable actuation mechanical keyboard with OLED display',
      price: 2200000,
      imageUrl:
          'https://i.ebayimg.com/images/g/UGgAAOSwYadhuUWc/s-l1200.jpg',
      category: 'Keyboard',
    ),
    Product(
      id: 'p9',
      name: 'Corsair HS70 Pro Wireless Gaming Headset',
      description: 'Wireless headset with 7.1 surround sound',
      price: 1300000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/0be4faea64eb6b82de576e25acb782f5',
      category: 'Headset',
    ),
    Product(
      id: 'p10',
      name: 'BenQ ZOWIE XL2546 Gaming Monitor',
      description: '24.5 inch 240Hz 1080p gaming monitor with DyAc technology',
      price: 6500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/6/15/6a43a666-2ba3-4326-b1bf-7119cd04b95b.jpg',
      category: 'Monitor',
    ),
    Product(
      id: 'p11',
      name: 'Logitech G Pro X Superlight Wireless Mouse',
      description: 'Ultra-lightweight wireless gaming mouse',
      price: 2000000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/id-11134207-7r990-lmmt0kl37lwh28',
      category: 'Mouse',
    ),
    Product(
      id: 'p12',
      name: 'ASUS TUF Gaming VG27AQ Monitor',
      description: '27 inch 165Hz 2560x1440 IPS gaming monitor',
      price: 7500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/1/20/93e7b105-9d7a-4913-ab97-1ab116878ecd.jpg',
      category: 'Monitor',
    ),
    Product(
      id: 'p13',
      name: 'PlayStation 5 Console',
      description:
          'Next-gen gaming console with ultra-fast SSD and immersive haptics',
      price: 9500000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/id-11134207-7ras8-m45j8ysf0rkz22',
      category: 'Console',
    ),
    Product(
      id: 'p14',
      name: 'Nintendo Switch OLED',
      description: 'Handheld and home console hybrid with OLED display',
      price: 5500000,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfQe0SdreX4rfeG-EVjRf2wjukTSmoB8tUZQ&s',
      category: 'Console',
    ),
    Product(
      id: 'p15',
      name: 'Elgato Stream Deck XL',
      description:
          '32 customizable LCD keys for streaming and productivity',
      price: 4500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/1500/VqbcmM/2024/2/11/064dafa9-80cf-46db-b5b5-2a46bd58b448.jpg',
      category: 'Streaming Gear',
    ),
    Product(
      id: 'p16',
      name: 'Cooler Master MM711 Mouse',
      description: 'Ultra-lightweight honeycomb gaming mouse',
      price: 750000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/1/22/b97a641e-f03a-4691-aa28-ceb32a7e6fcc.jpg',
      category: 'Mouse',
    ),
    Product(
      id: 'p17',
      name: 'ASUS ROG Chakram Wireless Mouse',
      description: 'High-performance mouse with programmable joystick',
      price: 2200000,
      imageUrl:
          'https://www.gaminggearskh.com/Content/Upload/ItemImage/6d372559-5b38-4985-acfb-48a134f771b0.jpg',
      category: 'Mouse',
    ),
    Product(
      id: 'p18',
      name: 'Logitech G733 Lightspeed Headset',
      description: 'Wireless RGB gaming headset with Blue VO!CE mic',
      price: 2200000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/1b300a9a3622c1fe895fff89dddece61',
      category: 'Headset',
    ),
    Product(
      id: 'p19',
      name: 'HyperX Alloy Origins Keyboard',
      description:
          'Compact RGB mechanical keyboard with HyperX switches',
      price: 1500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2022/10/7/dfc9f836-a101-49f2-9e2e-d8d913ba81a1.jpg',
      category: 'Keyboard',
    ),
    Product(
      id: 'p20',
      name: 'Razer Viper Ultimate Wireless Mouse',
      description: 'Ambidextrous lightweight wireless gaming mouse',
      price: 2000000,
      imageUrl:
          'https://m.media-amazon.com/images/I/71sByIUBKuL._AC_UF350,350_QL80_.jpg',
      category: 'Mouse',
    ),
    Product(
      id: 'p21',
      name: 'ASUS ROG Strix Scope RX Keyboard',
      description:
          'RGB mechanical keyboard with ROG RX optical switches',
      price: 2000000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/10/13/e40afb03-0b8d-415d-b783-dcba405bfd97.jpg',
      category: 'Keyboard',
    ),
    Product(
      id: 'p22',
      name: 'SteelSeries Arctis 7 Wireless Headset',
      description:
          'Lossless wireless audio with DTS Headphone:X v2.0',
      price: 2500000,
      imageUrl:
          'https://ae01.alicdn.com/kf/A219a5a794fbe4111a21501e2c4d1470a4.jpg',
      category: 'Headset',
    ),
    Product(
      id: 'p23',
      name: 'Samsung Odyssey G7 Gaming Monitor',
      description: '32 inch curved 240Hz QHD gaming monitor',
      price: 13000000,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnooEzdoVCgIbQAYgVfTHOcshPBDjzG2LKZQ&s',
      category: 'Monitor',
    ),
    Product(
      id: 'p24',
      name: 'Logitech G Pro X Gaming Headset',
      description:
          'Professional-grade wired headset with Blue VO!CE mic',
      price: 1800000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/2a07263d594a3186003952ea0dbbcc9f',
      category: 'Headset',
    ),
    Product(
      id: 'p25',
      name: 'Razer Huntsman Elite Keyboard',
      description:
          'Opto-mechanical keyboard with customizable RGB lighting',
      price: 2200000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/0309416d7621dcf00228de8e1203c38f',
      category: 'Keyboard',
    ),
    Product(
      id: 'p26',
      name: 'Logitech G560 RGB Speakers',
      description:
          'Gaming speakers with RGB lighting and DTS:X Ultra',
      price: 2600000,
      imageUrl:
          'https://down-my.img.susercontent.com/file/sg-11134201-22110-gf8zsm8ovvjv29',
      category: 'Speakers',
    ),
    Product(
      id: 'p27',
      name: 'Corsair K95 RGB Platinum Keyboard',
      description:
          'Mechanical keyboard with Cherry MX switches and RGB',
      price: 2500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/500-square/product-1/2020/4/5/53113341/53113341_b0f2265d-28f5-48c2-a9da-cf5a3d099811_1200_1200',
      category: 'Keyboard',
    ),
    Product(
      id: 'p28',
      name: 'Logitech MX Master 3 Mouse',
      description: 'Advanced wireless mouse with ergonomic design',
      price: 1500000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/9/3/60a53072-964c-4945-9c5b-7af8784b3e19.jpg',
      category: 'Mouse',
    ),
    Product(
      id: 'p29',
      name: 'HyperX Pulsefire Surge RGB Mouse',
      description: 'RGB gaming mouse with precision sensor',
      price: 900000,
      imageUrl:
          'https://down-id.img.susercontent.com/file/id-11134207-7r98u-lm43ljoblgvo61',
      category: 'Mouse',
    ),
    Product(
      id: 'p30',
      name: 'Razer Kiyo Streaming Camera',
      description:
          '1080p 30fps adjustable ring light streaming camera',
      price: 1200000,
      imageUrl:
          'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/11/12/8d917a63-6127-4f75-8eb1-ad3c6c8ffb1d.jpg',
      category: 'Streaming Gear',
    ),
  ];

  // Getter untuk semua produk
  List<Product> get products => [..._products];

  // Getter untuk list kategori unik
  List<String> get categories {
    return _products.map((prod) => prod.category).toSet().toList();
  }

  // Mendapatkan produk berdasarkan kategori
  List<Product> productsByCategory(String category) {
    return _products.where((prod) => prod.category == category).toList();
  }

  // Mencari produk berdasarkan ID
  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  // Manajemen Cart
  final Map<String, Product> _cartItems = {};

  // Getter untuk produk di keranjang
  Map<String, Product> get cartItems => {..._cartItems};

  // Jumlah item di keranjang
  int get cartCount => _cartItems.length;

  // Menambahkan produk ke keranjang
  void addToCart(Product product) {
    if (!_cartItems.containsKey(product.id)) {
      _cartItems[product.id] = product;
      notifyListeners();
    }
  }

  // Menghapus produk dari keranjang
  void removeFromCart(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.remove(productId);
      notifyListeners();
    }
  }

  // Mengosongkan keranjang
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
