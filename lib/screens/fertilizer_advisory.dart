import 'package:flutter/material.dart';

class FertilizerAdvisoryScreen extends StatelessWidget {
  const FertilizerAdvisoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertilizer Advisory'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _PlanCard(
            title: 'Recommended Plan',
            subtitle: 'Based on current soil metrics',
            color: Colors.orange,
            items: [
              'Urea: 20 kg/ha',
              'DAP: 15 kg/ha',
              'MOP: 10 kg/ha',
            ],
          ),
          SizedBox(height: 12),
          _PlanCard(
            title: 'Application Tips',
            subtitle: 'Improve nutrient uptake',
            color: Colors.green,
            items: [
              'Apply in cool hours',
              'Avoid waterlogging',
              'Split doses over 2 weeks',
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final Color color;
  const _PlanCard({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.spa, color: color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final i in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 18),
                  const SizedBox(width: 8),
                  Text(i),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
