import 'package:flutter/material.dart';

class OrderSummaryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final double price;
  const OrderSummaryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Color(0xFFFE8D11)),
      title: Text(title, style: TextStyle(fontSize: 18)),
      trailing: Text(
        '\$${price.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
