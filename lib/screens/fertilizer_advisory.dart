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
          _BioFertilizerCard(),
          SizedBox(height: 12),
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
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

class _BioFertilizerCard extends StatelessWidget {
  const _BioFertilizerCard();

  @override
  Widget build(BuildContext context) {
    final titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    final chipStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
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
                  color: Colors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.eco, color: Colors.teal),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bio‑Fertilizer Recommendation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('UI only • tailored by soil health', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Key Inputs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Chip(tag: 'Compost'),
              _Chip(tag: 'Vermicompost'),
              _Chip(tag: 'Farmyard Manure'),
              _Chip(tag: 'Azotobacter'),
              _Chip(tag: 'Rhizobium'),
              _Chip(tag: 'PSB'),
              _Chip(tag: 'Trichoderma'),
            ],
          ),
          const SizedBox(height: 16),
          Text('Steps', style: titleStyle),
          const SizedBox(height: 8),
          const _StepItem(index: 1, text: 'Collect dry organic matter; shred to improve decomposition'),
          const _StepItem(index: 2, text: 'Moisten to 60–65%; maintain aerobic conditions'),
          const _StepItem(index: 3, text: 'Inoculate with culture (e.g., Azotobacter/PSB) uniformly'),
          const _StepItem(index: 4, text: 'Cure for 15–30 days; turn periodically'),
          const _StepItem(index: 5, text: 'Apply near root zone; avoid waterlogging post-application'),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.info_outline, size: 16, color: Colors.teal),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Final doses and cultures will adapt to soil health data.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String tag;
  const _Chip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Text(
        tag,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int index;
  final String text;
  const _StepItem({required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.withValues(alpha: 0.4)),
            ),
            child: Text(
              '$index',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
