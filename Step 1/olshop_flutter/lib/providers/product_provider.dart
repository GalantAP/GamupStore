import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Logitech G502 Hero Gaming Mouse',
      description: 'High precision gaming mouse with 16000 DPI sensor',
      price: 750000,
      imageUrl: 'https://images.tokopedia.net/img/cache/700/VqbcmM/2020/9/9/492f9ad7-6262-4837-aa44-5083c50d7b69.png',
    ),
    Product(
      id: 'p2',
      name: 'Razer BlackWidow V3 Mechanical Keyboard',
      description: 'RGB mechanical keyboard with tactile switches',
      price: 1500000,
      imageUrl: 'https://images.tokopedia.net/img/cache/700/product-1/2020/9/3/3393118/3393118_a5892eb4-5e54-4775-8c78-691b13a30a15_1040_1040',
    ),
    Product(
      id: 'p3',
      name: 'HyperX Cloud II Gaming Headset',
      description: '7.1 surround sound wired gaming headset',
      price: 1100000,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98z-lrqvuofz4r3b28',
    ),
    Product(
      id: 'p4',
      name: 'Secretlab Titan Gaming Chair',
      description: 'Ergonomic gaming chair with adjustable lumbar support',
      price: 7500000,
      imageUrl: 'https://images.tokopedia.net/img/cache/700/VqbcmM/2024/12/19/2a8170a7-b566-4b4b-af7c-b67d8db0a26a.jpg',
    ),
    Product(
      id: 'p5',
      name: 'ASUS ROG Swift PG279Q Gaming Monitor',
      description: '27 inch 144Hz 2560x1440 IPS display monitor',
      price: 9000000,
      imageUrl: 'https://images.tokopedia.net/img/cache/700/VqbcmM/2023/6/16/aace93d3-e007-458d-9cd7-78cb9df9712f.jpg',
    ),
    Product(
      id: 'p6',
      name: 'MSI GE66 Raider Gaming Laptop',
      description: 'Intel i7, RTX 3070, 16GB RAM high-performance laptop',
      price: 25000000,
      imageUrl: 'https://images.tokopedia.net/img/cache/700/OJWluG/2022/5/12/92fa46e3-463c-4431-a435-7a97de0559ab.jpg',
    ),
    Product(
      id: 'p7',
      name: 'Xbox Wireless Controller',
      description: 'Wireless controller with vibration feedback',
      price: 850000,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98u-lvsw4x9c6igsb6',
    ),
    Product(
      id: 'p8',
      name: 'SteelSeries Apex Pro Mechanical Keyboard',
      description: 'Adjustable actuation mechanical keyboard with OLED display',
      price: 2200000,
      imageUrl: 'https://i.ebayimg.com/images/g/UGgAAOSwYadhuUWc/s-l1200.jpg',
    ),
    Product(
      id: 'p9',
      name: 'Corsair HS70 Pro Wireless Gaming Headset',
      description: 'Wireless headset with 7.1 surround sound',
      price: 1300000,
      imageUrl: 'https://down-id.img.susercontent.com/file/0be4faea64eb6b82de576e25acb782f5',
    ),
    Product(
      id: 'p10',
      name: 'BenQ ZOWIE XL2546 Gaming Monitor',
      description: '24.5 inch 240Hz 1080p gaming monitor with DyAc technology',
      price: 6500000,
      imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/6/15/6a43a666-2ba3-4326-b1bf-7119cd04b95b.jpg',
    ),
    Product(
      id: 'p11',
      name: 'Logitech G Pro X Superlight Wireless Mouse',
      description: 'Ultra-lightweight wireless gaming mouse',
      price: 2000000,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r990-lmmt0kl37lwh28',
    ),
    Product(
      id: 'p12',
      name: 'ASUS TUF Gaming VG27AQ Monitor',
      description: '27 inch 165Hz 2560x1440 IPS gaming monitor',
      price: 7500000,
      imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/1/20/93e7b105-9d7a-4913-ab97-1ab116878ecd.jpg',
    ),
    Product(
  id: 'p13',
  name: 'PlayStation 5 Console',
  description: 'Next-gen gaming console with ultra-fast SSD and immersive haptics',
  price: 9500000,
  imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7ras8-m45j8ysf0rkz22',
),
Product(
  id: 'p14',
  name: 'Nintendo Switch OLED',
  description: 'Handheld and home console hybrid with OLED display',
  price: 5500000,
  imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfQe0SdreX4rfeG-EVjRf2wjukTSmoB8tUZQ&s',
),
Product(
  id: 'p15',
  name: 'Elgato Stream Deck XL',
  description: '32 customizable LCD keys for streaming and productivity',
  price: 4500000,
  imageUrl: 'https://images.tokopedia.net/img/cache/1500/VqbcmM/2024/2/11/064dafa9-80cf-46db-b5b5-2a46bd58b448.jpg',
),
Product(
  id: 'p16',
  name: 'Cooler Master MM711 Mouse',
  description: 'Ultra-lightweight honeycomb gaming mouse',
  price: 750000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/1/22/b97a641e-f03a-4691-aa28-ceb32a7e6fcc.jpg',
),
Product(
  id: 'p17',
  name: 'ASUS ROG Chakram Wireless Mouse',
  description: 'High-performance mouse with programmable joystick',
  price: 2200000,
  imageUrl: 'https://www.gaminggearskh.com/Content/Upload/ItemImage/6d372559-5b38-4985-acfb-48a134f771b0.jpg',
),
Product(
  id: 'p18',
  name: 'Logitech G733 Lightspeed Headset',
  description: 'Wireless RGB gaming headset with Blue VO!CE mic',
  price: 2200000,
  imageUrl: 'https://down-id.img.susercontent.com/file/1b300a9a3622c1fe895fff89dddece61',
),
Product(
  id: 'p19',
  name: 'HyperX Alloy Origins Keyboard',
  description: 'Compact RGB mechanical keyboard with HyperX switches',
  price: 1500000,
  imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2022/10/7/dfc9f836-a101-49f2-9e2e-d8d913ba81a1.jpg',
),
Product(
  id: 'p20',
  name: 'Razer Viper Ultimate Wireless Mouse',
  description: 'Ambidextrous lightweight wireless gaming mouse',
  price: 2000000,
  imageUrl: 'https://m.media-amazon.com/images/I/71sByIUBKuL._AC_UF350,350_QL80_.jpg',
),
Product(
  id: 'p21',
  name: 'ASUS ROG Strix Scope RX Keyboard',
  description: 'RGB mechanical keyboard with ROG RX optical switches',
  price: 2000000,
  imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/10/13/e40afb03-0b8d-415d-b783-dcba405bfd97.jpg',
),
Product(
  id: 'p22',
  name: 'SteelSeries Arctis 7 Wireless Headset',
  description: 'Lossless wireless audio with DTS Headphone:X v2.0',
  price: 2500000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/VqbcmM/2022/5/24/2de7d66d-b89c-40c8-9edf-e3823451d04d.jpg',
),
Product(
  id: 'p23',
  name: 'Logitech G560 RGB Speakers',
  description: '2.1 speaker system with Lightsync RGB',
  price: 3300000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/product-1/2019/11/15/12737320/12737320_c400d53c-dd32-4dee-940e-02931188ba2a_600_600',
),
Product(
  id: 'p24',
  name: 'Alienware AW2521H Monitor',
  description: '24.5 inch 360Hz gaming monitor with NVIDIA G-SYNC',
  price: 11000000,
  imageUrl: 'https://down-id.img.susercontent.com/file/966fe424dcfdbb044ba295dc8ac53efc',
),
Product(
  id: 'p25',
  name: 'Gigabyte AORUS FI27Q Monitor',
  description: '27 inch 165Hz IPS QHD gaming monitor',
  price: 8500000,
  imageUrl: 'https://down-id.img.susercontent.com/file/f0b32283130aae577bd5981476ada300',
),
Product(
  id: 'p26',
  name: 'Razer Seiren X Microphone',
  description: 'USB condenser microphone for streaming',
  price: 1300000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/product-1/2020/5/1/77732607/77732607_482a33e1-0991-4f02-9c7c-15e8c2bd20c0_700_700',
),
Product(
  id: 'p27',
  name: 'MSI Optix MAG274QRF-QD Monitor',
  description: '27 inch Rapid IPS QHD gaming monitor with Quantum Dot',
  price: 7800000,
  imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/5/21/6a4c7124-a53a-4391-bacb-6c7767706ea0.jpg',
),
Product(
  id: 'p28',
  name: 'Xbox Series X Console',
  description: 'Most powerful next-gen Xbox console with 1TB SSD',
  price: 9500000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/hDjmkQ/2024/1/16/7c72d7d5-b7a8-4035-a987-ecb34e826426.jpg',
),
Product(
  id: 'p29',
  name: 'HyperX QuadCast Microphone',
  description: 'Professional USB condenser microphone for streamers',
  price: 2500000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/hDjmkQ/2024/3/2/77d61f68-4bc0-42ba-a9f0-a141b31cf0eb.jpg',
),
Product(
  id: 'p30',
  name: 'Razer Basilisk Ultimate Mouse',
  description: 'Customizable wireless gaming mouse with charging dock',
  price: 2500000,
  imageUrl: 'https://images.tokopedia.net/img/cache/700/product-1/2020/4/17/1019477/1019477_e5a8ba26-2184-4596-9c77-4b2957c62f90_554_554.jpg',
),

  ];

  List<Product> get products => [..._products];

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
}
