import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class SellerSection extends StatelessWidget {
  final String sellerName;
  final int itemCount;
  final String? sellerImageUrl;
  final VoidCallback? onTap;

  const SellerSection({super.key, required this.sellerName, required this.itemCount, this.sellerImageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: context.color.stroke),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Продавец', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: const Color(0xFFE8F5F3), borderRadius: BorderRadius.circular(12)),
                    child: sellerImageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(sellerImageUrl!, fit: BoxFit.cover),
                          )
                        : const Icon(Icons.store_outlined, color: Color(0xFF00A693)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sellerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(
                          '$itemCount объявлений товаров',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
