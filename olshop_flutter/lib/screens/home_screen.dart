import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_item.dart';
import '../utils/page_transitions.dart';
import 'chat_list_screen.dart';

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
    List products = productProvider.products;

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

    final List<String> categories = ['All', ...productProvider.categories];
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth >= 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        title: const Text(
          'GamUp Store',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 1.1),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatListScreen()),
          );
        },
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text('Chat Admin'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Greeting
            _greetingCard(),

            // Main Card (search, filter, category)
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.shade200.withAlpha(80),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 34),
              child: Column(
                children: [
                  // Search & filter row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Cari game, voucher...',
                            hintStyle: TextStyle(
                              color: Colors.indigo.shade700.withAlpha(160),
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.indigo.shade700),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                          onChanged: (value) => setState(() {
                            searchQuery = value;
                          }),
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: products.isEmpty ? Colors.grey : Colors.indigo.shade700,
                          elevation: 5,
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
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        child: Icon(Icons.sort_rounded, size: 28, color: products.isEmpty ? Colors.black26 : Colors.white),
                      ),
                      const SizedBox(width: 10),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.indigo.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),

                  // Category Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white, width: 1.7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(28),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                        dropdownColor: Colors.indigo.shade900,
                        style: const TextStyle(
                          color: Colors.white,
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Promo Carousel
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: CarouselSlider.builder(
                      itemCount: promoBanners.length,
                      options: CarouselOptions(
                        height: isWideScreen ? 240 : 160,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
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
                                color: Colors.black.withAlpha(20),
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
                                      Color.fromARGB(130, 0, 0, 0),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 12,
                                left: 0,
                                right: 0,
                                child: Center(
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
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Product Section
            const SizedBox(height: 26),
            Text(
              '${products.length} produk ditemukan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade900,
              ),
            ),
            const SizedBox(height: 14),
            if (products.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    searchQuery.trim().isNotEmpty
                        ? 'Produk tidak ditemukan'
                        : 'Tidak ada produk tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade400,
                    ),
                  ),
                ),
              ),
            if (products.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWideScreen ? 4 : 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.74,
                ),
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  final product = products[i];
                  return _ProductCard(product: product);
                },
              ),
          ],
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

  Widget _greetingCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/admin.jpg',
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, Galant 👋',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo.shade900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Siap belanja hari ini?',
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final dynamic product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _onEnter(PointerEvent event) => setState(() => _isHovered = true);
  void _onExit(PointerEvent event) => setState(() => _isHovered = false);
  void _onTapDown(TapDownDetails details) => setState(() => _isPressed = true);
  void _onTapUp(TapUpDetails details) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final Color baseShadowColor = Colors.indigo.shade900.withAlpha(80);
    final BoxShadow boxShadow = BoxShadow(
      color: baseShadowColor,
      blurRadius: _isHovered ? 45 : _isPressed ? 25 : 12,
      spreadRadius: _isHovered ? 8 : _isPressed ? 4 : 2,
      offset: const Offset(0, 8),
    );
    final double scale = _isPressed ? 0.97 : 1.0;

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: () {
          Navigator.pushNamed(context, '/product_detail', arguments: widget.product.id);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
            boxShadow: [boxShadow],
            border: Border.all(
              color: _isHovered ? Colors.indigo.shade400 : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: ProductItem(product: widget.product),
          ),
        ),
      ),
    );
  }
}
