import 'package:flutter/material.dart';

class PickupInfoCard extends StatelessWidget {
  const PickupInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFE8F5F3), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Image.asset("assets/images/location.png"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Товар можно забрать по указанному адресу',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}
