import 'package:burger_shop/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityCounter extends StatelessWidget {
  final String productId;
  const QuantityCounter({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CartProvider>();
    final quantity = provider.getQuantities(productId);
    return Container(
      height: 34,
      width: MediaQuery.of(context).size.width * 0.20,
      decoration: BoxDecoration(
        color: Color(0xFFFEF4E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: InkWell(
                onTap: () {
                  if (quantity > 0) {
                    provider.decrementQuantity(productId);
                  }
                },
                child: const Icon(Icons.minimize),
              ),
            ),
            Text(
              quantity.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            InkWell(
              onTap: () {
                provider.incrementQuantity(productId);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
