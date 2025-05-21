import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String sortBy = 'None';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;

    // Filter berdasarkan kategori
    if (selectedCategory != 'All') {
      products = products.where((p) => p.category == selectedCategory).toList();
    }

    // Sort harga
    if (sortBy == 'Highest') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy == 'Lowest') {
      products.sort((a, b) => a.price.compareTo(b.price));
    }

    // List kategori dari product list
    final categories = ['All', ...productProvider.categories];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamup Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter dan Sort Row
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // Dropdown kategori
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 10),
                // Dropdown Sort
                Expanded(
                  child: DropdownButton<String>(
                    value: sortBy,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        sortBy = value!;
                      });
                    },
                    items: ['None', 'Highest', 'Lowest'].map((sortOption) {
                      return DropdownMenuItem(
                        value: sortOption,
                        child: Text(sortOption),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // GridView produk
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, i) => ProductItem(product: products[i]),
            ),
          ),
        ],
      ),
    );
  }
}
