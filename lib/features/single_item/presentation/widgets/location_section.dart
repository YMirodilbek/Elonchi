import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class LocationSection extends StatelessWidget {
  final String address;
  final String? mapImagePath;
  final VoidCallback? onMapTap;

  const LocationSection({super.key, required this.address, this.mapImagePath, this.onMapTap});

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
          const Text('Место сделки', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onMapTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 150,
                color: Colors.grey.shade300,
                child: mapImagePath != null
                    ? Image.asset(mapImagePath!, fit: BoxFit.cover)
                    : Center(child: Icon(Icons.map_outlined, size: 48, color: Colors.grey.shade600)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(address, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
