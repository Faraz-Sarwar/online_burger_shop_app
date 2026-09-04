import 'package:flutter/material.dart';

class ContainerRow extends StatelessWidget {
  final String text;
  final int currentIndex;
  final int index;
  const ContainerRow({
    super.key,
    required this.text,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 16),
          height: 46,
          width: 120,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.orangeAccent : null,
            border: Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: currentIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
