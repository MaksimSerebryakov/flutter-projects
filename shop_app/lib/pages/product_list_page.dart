import 'package:flutter/material.dart';
import 'package:shop_app/pages/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';
import 'package:shop_app/global_variables.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Puma'];

  late List<String> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    selectedFilters.add('All');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 167, 167, 167)),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  style: TextStyle(fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (filter != 'All') {
                        if (selectedFilters.contains('All')) {
                          selectedFilters.clear();
                        }
                        if (selectedFilters.contains(filter)) {
                          if (selectedFilters.length == 1) {
                            selectedFilters = ['All'];
                          } else {
                            selectedFilters.remove(filter);
                          }
                        } else {
                          selectedFilters.add(filter);
                        }
                      } else {
                        selectedFilters = ['All'];
                      }

                      setState(() {});
                    },
                    child: Chip(
                      backgroundColor: selectedFilters.contains(filter)
                          ? const Color.fromARGB(255, 159, 109, 192)
                          : const Color.fromARGB(255, 240, 237, 237),
                      label: Text(
                        filter,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 53, 53, 53)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 650) {
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromARGB(255, 209, 193, 235)
                              : const Color.fromARGB(255, 240, 237, 237),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromARGB(255, 209, 193, 235)
                              : const Color.fromARGB(255, 240, 237, 237),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
