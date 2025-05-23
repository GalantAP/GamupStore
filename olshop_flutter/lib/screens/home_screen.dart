import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  String selectedSort = 'None';
  bool isCategoryDropdownOpen = false;

  final List<String> promoBanners = [
    'assets/images/banner/promo1.jpg',
    'assets/images/banner/promo2.jpg',
    'assets/images/banner/promo3.jpg',
  ];

  void toggleCategoryDropdown() {
    setState(() {
      isCategoryDropdownOpen = !isCategoryDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;

    // Filter kategori
    if (selectedCategory != 'All') {
      products = products.where((p) => p.category == selectedCategory).toList();
    }

    // Filter search
    if (searchQuery.isNotEmpty) {
      products = products
          .where((p) =>
              p.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Sorting
    if (selectedSort == 'Highest') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedSort == 'Lowest') {
      products.sort((a, b) => a.price.compareTo(b.price));
    }

    final categories = ['All', ...productProvider.categories];

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 2,
        title: const Text(
          'Gamup Store',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Banner Promo
            CarouselSlider(
              options: CarouselOptions(
                height: 160.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                enableInfiniteScroll: true,
              ),
              items: promoBanners.map((bannerPath) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        bannerPath,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Search Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search games...',
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            // Category Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: toggleCategoryDropdown,
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category: $selectedCategory',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[900],
                            ),
                          ),
                          Icon(
                            isCategoryDropdownOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 24,
                            color: Colors.blue[900],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isCategoryDropdownOpen)
                    Divider(height: 1, color: Colors.blue[100]),
                  if (isCategoryDropdownOpen)
                    SizedBox(
                      height: categories.length * 48.0,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                                isCategoryDropdownOpen = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              color: isSelected
                                  ? Colors.blue.withOpacity(0.15)
                                  : null,
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isSelected
                                      ? Colors.blue[800]
                                      : Colors.blueGrey[900],
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Sort & Total Item
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${products.length} items',
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sort by Price',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  leading: Icon(
                                    selectedSort == 'None'
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: Colors.blue,
                                  ),
                                  title: const Text('Default'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'None';
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    selectedSort == 'Highest'
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: Colors.blue,
                                  ),
                                  title: const Text('Highest Price'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'Highest';
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    selectedSort == 'Lowest'
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: Colors.blue,
                                  ),
                                  title: const Text('Lowest Price'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'Lowest';
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.sort, color: Colors.blue, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            selectedSort == 'None'
                                ? 'Sort by'
                                : (selectedSort == 'Highest'
                                    ? 'Highest Price'
                                    : 'Lowest Price'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[800],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down,
                              size: 20, color: Colors.blue[800]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Grid Produk
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  final product = products[i];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    shadowColor: Colors.blue.withOpacity(0.15),
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, '/product-detail', arguments: product.id);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: ProductItem(product: product),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
