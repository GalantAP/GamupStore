import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';  // Import carousel_slider

import '../providers/product_provider.dart';
import '../widgets/product_item.dart';
import '../utils/page_transitions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route route() {
    return PageTransitions.fadeSlideFromRight(const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  String selectedSort = 'None';

  final List<String> promoBanners = [
    'assets/images/banner/promo1.jpg',
    'assets/images/banner/promo2.jpg',
    'assets/images/banner/promo3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;

    if (selectedCategory != 'All') {
      products = products.where((p) => p.category == selectedCategory).toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      products = products.where((p) => p.name.toLowerCase().contains(query)).toList();
    }

    if (selectedSort == 'Highest') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedSort == 'Lowest') {
      products.sort((a, b) => a.price.compareTo(b.price));
    }

    final categories = ['All', ...productProvider.categories];

    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 600;

    final Color dropdownBgColor = Colors.indigo.shade700;
    final Color dropdownTextColor = Colors.white;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        title: const Text(
          'GamUp Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 26),
            tooltip: 'Keranjang',
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, size: 26),
            tooltip: 'Profil',
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Promo Banner Carousel
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: CarouselSlider.builder(
                  itemCount: promoBanners.length,
                  options: CarouselOptions(
                    height: isWideScreen ? 280 : 190,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.88,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enableInfiniteScroll: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 38).withAlpha((0.15 * 255).round()),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.asset(
                              promoBanners[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0.55),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Text(
                              'Promo Spesial Minggu Ini!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Search & Filter Row
              Row(
                children: [
                  // Search bar dengan background putih dan outline biru
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.indigo.shade700, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade700.withAlpha((0.15 * 255).round()),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Cari game...',
                          hintStyle: TextStyle(color: Colors.indigo.shade700.withAlpha((0.5 * 255).round())),
                          prefixIcon: Icon(Icons.search, color: Colors.indigo.shade700),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        onChanged: (value) => setState(() {
                          searchQuery = value;
                        }),
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Sort button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: products.isEmpty ? Colors.grey : Colors.indigo.shade700,
                      elevation: 5,
                      shadowColor: const Color.fromRGBO(72, 81, 231, 0.3),
                    ),
                    onPressed: products.isEmpty
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Urutkan berdasarkan harga',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildSortOption('None', 'Default'),
                                      _buildSortOption('Highest', 'Harga Tertinggi'),
                                      _buildSortOption('Lowest', 'Harga Terendah'),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                    child: Icon(Icons.sort, size: 28, color: products.isEmpty ? Colors.black26 : Colors.white),
                  ),

                  const SizedBox(width: 14),

                  // Clear filter button
                  OutlinedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        selectedCategory = 'All';
                        searchQuery = '';
                        selectedSort = 'None';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.indigo.shade700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(
                      'Reset Filter',
                      style: TextStyle(
                        color: Colors.indigo.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Dropdown kategori satu warna dengan tombol filter (biru), teks putih, outline putih
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: dropdownBgColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: dropdownBgColor.withAlpha((0.1 * 255).round()),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                    dropdownColor: dropdownBgColor,
                    style: TextStyle(
                      color: dropdownTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (String? value) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: categories
                        .map(
                          (category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(
                              category,
                              style: TextStyle(
                                fontWeight: category == selectedCategory ? FontWeight.bold : FontWeight.normal,
                                color: dropdownTextColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Jumlah produk
              Text(
                '${products.length} item${products.length == 1 ? '' : 's'} ditemukan',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade900,
                ),
              ),

              const SizedBox(height: 14),

              // Pesan kosong jika produk tidak ada
              if (products.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      searchQuery.trim().isNotEmpty ? 'Produk tidak ditemukan' : 'Tidak ada produk tersedia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo.shade400,
                      ),
                    ),
                  ),
                ),

              // Grid produk
              if (products.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWideScreen ? 4 : 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (ctx, i) {
                      final product = products[i];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 5,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 0.12),
                        child: InkWell(
                          onTap: () {
                            // Navigasi ke detail produk jika perlu
                          },
                          borderRadius: BorderRadius.circular(18),
                          child: ProductItem(product: product), // Hapus onAddToCart jika error
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortOption(String value, String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selectedSort == value ? Icons.check_circle_rounded : Icons.circle_outlined,
        color: Colors.indigo.shade700,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selectedSort == value ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          selectedSort = value;
        });
        Navigator.pop(context);
      },
    );
  }
}
