import 'package:flutter/material.dart';

class SoilHealthDashboardScreen extends StatelessWidget {
  const SoilHealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soil Health Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StatTile(
            title: 'Nitrogen',
            value: '70 ppm',
            status: 'Optimal',
            color: Colors.green,
          ),
          _StatTile(
            title: 'Phosphorus',
            value: '30 ppm',
            status: 'Low',
            color: Colors.amber,
          ),
          _StatTile(
            title: 'Potassium',
            value: '180 ppm',
            status: 'High',
            color: Colors.blue,
          ),
          _StatTile(
            title: 'Soil pH',
            value: '6.5',
            status: 'Optimal',
            color: Colors.deepPurple,
          ),
          _StatTile(
            title: 'Temperature',
            value: '28°C',
            status: 'Warm',
            color: Colors.red,
          ),
          _StatTile(
            title: 'Humidity',
            value: '82%',
            status: 'High',
            color: Colors.cyan,
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String title;
  final String value;
  final String status;
  final Color color;
  const _StatTile({
    required this.title,
    required this.value,
    required this.status,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.analytics, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(value),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
