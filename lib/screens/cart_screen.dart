import 'package:burger_shop/components/order_summary_tile.dart';
import 'package:burger_shop/components/quantity_counter.dart';
import 'package:burger_shop/global/items_in_cart.dart';
import 'package:burger_shop/provider/cart_provider.dart';
import 'package:burger_shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider provider = Provider.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    ),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBF1E5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Your order',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              cart.isEmpty
                  ? Column(
                      children: <Widget>[
                        const Center(
                          child: Text(
                            'Your cart looks empty!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final product = cart[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Image.asset(
                                    product['image'],
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.10,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product['name'] ?? "",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '\$${provider.calculateTotal(product['id'].toString(), product['price']).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                Text(
                                                  '${product['rating'].toString()} (${cart[index]['reviews'].toString()})',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      cart.remove(product);
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Color(0xFFFE8D11),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            QuantityCounter(
                                              productId: product['id']
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              Visibility(
                visible: cart.isNotEmpty ? true : false,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        OrderSummaryTile(
                          icon: Icons.shopping_bag_outlined,
                          title: 'Subtotal (${cart.length})',
                          price: provider.getCartTotal(cart),
                        ),
                        OrderSummaryTile(
                          icon: Icons.delivery_dining_sharp,
                          title: 'Shipping fee',
                          price: 0,
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 211, 211, 211),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${provider.getCartTotal(cart).toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Color(0xFFFE8D11),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: cart.isNotEmpty ? true : false,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFE8D11),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          'Proceed to checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
