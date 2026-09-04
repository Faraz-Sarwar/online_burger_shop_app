import 'package:burger_shop/components/container_row.dart';
import 'package:burger_shop/components/product_card.dart';
import 'package:burger_shop/global/categories.dart';
import 'package:burger_shop/global/products_info.dart';
import 'package:burger_shop/screens/cart_screen.dart';
import 'package:burger_shop/screens/login.dart';
import 'package:burger_shop/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];
  @override
  void initState() {
    super.initState();
    for (var p in products) {
      filteredProducts.add(p);
    }
  }

  void onSearchChanged(String query) {
    setState(() {
      final searchQuery = query.toLowerCase().trim();
      filteredProducts = products
          .where(
            (p) => p['name'].toString().toLowerCase().contains(searchQuery),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 247, 247),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 247, 247),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
                maxRadius: 24,
              ),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 147, 7),
                ),
                accountName: const Text('Faraz Sarwar'),
                accountEmail: const Text('faraz@gmail.com'),
                currentAccountPicture: const CircleAvatar(),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: const Text('Home'),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                ),
                child: ListTile(
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: const Text('Cart'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ),
                child: ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hey Faraz!\n',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Find and order\n',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Burger for you 🍔',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 32),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 230, 230, 230),
                    hintText: "Find your burger",
                    hintStyle: TextStyle(fontSize: 19),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),

                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ContainerRow(
                        text: category,
                        currentIndex: currentIndex,
                        index: index,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Most popular',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: filteredProducts.isEmpty ? 80 : 290,
                  child: filteredProducts.isEmpty
                      ? Center(
                          child: const Text(
                            "No products found!",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            bool isFavorite = product['isFavorite'] ?? false;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 6),
                                  width: 240,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26.withOpacity(0.1),
                                        offset: Offset(0.5, 1.1),
                                        spreadRadius: 1.4,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: AlignmentGeometry.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            product['isFavorite']
                                                ? ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(
                                                        seconds: 2,
                                                      ),
                                                      backgroundColor:
                                                          Colors.orangeAccent,
                                                      content: const Text(
                                                        'Removed from favourites',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      duration: const Duration(
                                                        seconds: 2,
                                                      ),
                                                      backgroundColor:
                                                          Colors.orangeAccent,
                                                      content: const Text(
                                                        'Added to favourites',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                            setState(() {
                                              product['isFavorite'] =
                                                  !product['isFavorite'];
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 34,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: const Color.fromARGB(
                                                255,
                                                255,
                                                225,
                                                223,
                                              ),
                                            ),
                                            child: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons
                                                        .favorite_border_outlined,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        product['image'],
                                        height: 150,
                                      ),
                                      Text(
                                        product['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          Text(product['rating'].toString()),
                                          const SizedBox(width: 4),
                                          Text('(${product['reviews']})'),
                                        ],
                                      ),
                                      Text(
                                        '\$${product['price'].toString()}',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recently ordered',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Order history',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 147, 7),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //Recently ordered products list.
                SizedBox(height: 260, child: const ProductCard()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
