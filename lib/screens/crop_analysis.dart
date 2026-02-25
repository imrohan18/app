import 'package:flutter/material.dart';

import 'package:agrisense_fronted/l10n/app_localizations.dart';

class CropAnalysisScreen extends StatefulWidget {
  final VoidCallback? onCheckSoilHealth;

  const CropAnalysisScreen({
    super.key,
    this.onCheckSoilHealth,
  });

  @override
  State<CropAnalysisScreen> createState() => _CropAnalysisScreenState();
}

class _CropAnalysisScreenState extends State<CropAnalysisScreen> {
  final Color primary = const Color(0xFFEC5B13);

  double n = 52;
  double p = 30;
  double k = 45;
  double ph = 6.5;
  double temp = 25;
  double humidity = 60;
  bool _showRecommendations = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _recommendedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Analysis'),
        centerTitle: true,
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Soil Parameters',
            child: Column(
              children: [
                _SliderRow(
                  label: 'Nitrogen (N)',
                  value: n,
                  unit: 'mg/kg',
                  color: Colors.orange,
                  onChanged: (v) => setState(() => n = v),
                ),
                const SizedBox(height: 8),
                _SliderRow(
                  label: 'Phosphorus (P)',
                  value: p,
                  unit: 'mg/kg',
                  color: Colors.deepOrange,
                  onChanged: (v) => setState(() => p = v),
                ),
                const SizedBox(height: 8),
                _SliderRow(
                  label: 'Potassium (K)',
                  value: k,
                  unit: 'mg/kg',
                  color: Colors.blue,
                  onChanged: (v) => setState(() => k = v),
                ),
                const SizedBox(height: 8),
                _SliderRow(
                  label: 'pH Level',
                  value: ph,
                  unit: 'pH',
                  min: 3,
                  max: 9,
                  color: Colors.purple,
                  onChanged: (v) => setState(() => ph = v),
                ),
                const SizedBox(height: 12),
                _SliderRow(
                  label: 'Temperature',
                  value: temp,
                  min: 0,
                  max: 45,
                  unit: '°C',
                  color: Colors.orange,
                  onChanged: (v) => setState(() => temp = v),
                ),
                const SizedBox(height: 8),
                _SliderRow(
                  label: 'Humidity',
                  value: humidity,
                  min: 0,
                  max: 100,
                  unit: '%',
                  color: Colors.cyan,
                  onChanged: (v) => setState(() => humidity = v),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _showRecommendations = true;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final ctx = _recommendedKey.currentContext;
                        if (ctx != null) {
                          Scrollable.ensureVisible(
                            ctx,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      });
                    },
                    child: const Text('Get Crop Recommendation'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _showRecommendations
                ? _SectionCard(
                    key: _recommendedKey,
                    title: 'Recommended Crops',
                    child: Column(
                      children: const [
                        _RecommendationTile(name: 'Rice', match: 0.86),
                        SizedBox(height: 10),
                        _RecommendationTile(name: 'Maize', match: 0.80),
                        SizedBox(height: 10),
                        _RecommendationTile(name: 'Jute', match: 0.72),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _showRecommendations
                ? _SectionCard(
                    title: 'Details',
                    child: _RecommendationTable(),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          if (_showRecommendations)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: widget.onCheckSoilHealth,
                child: Text(
                  AppLocalizations.of(context)?.checkSoilHealth ?? 'Check Soil Health',
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final String unit;
  final Color color;
  final ValueChanged<double> onChanged;
  const _SliderRow({
    required this.label,
    required this.value,
    this.min = 0,
    this.max = 100,
    required this.unit,
    required this.color,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.spa, color: color),
                const SizedBox(width: 6),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.2)),
              ),
              child: Text(
                '${value.toStringAsFixed(0)} $unit',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: color,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}


class _RecommendationTile extends StatelessWidget {
  final String name;
  final double match;
  const _RecommendationTile({required this.name, required this.match});
  @override
  Widget build(BuildContext context) {
    final percent = (match * 100).toStringAsFixed(0);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9DC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$percent% Match',
                  style: const TextStyle(
                    color: Color(0xFFEC5B13),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: match,
            minHeight: 8,
            color: const Color(0xFFEC5B13),
            backgroundColor: const Color(0xFFFFF3EC),
          ),
        ],
      ),
    );
  }
}

class _RecommendationTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Crop')),
          DataColumn(label: Text('Nutrients')),
          DataColumn(label: Text('Water & Mixed')),
          DataColumn(label: Text('Reason')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('Rice')),
            DataCell(Text('N: Optimal, P: Low, K: High')),
            DataCell(Text('Medium water')),
            DataCell(Text('High K & suitable pH')),
          ]),
          DataRow(cells: [
            DataCell(Text('Maize')),
            DataCell(Text('N: Medium, P: Medium, K: High')),
            DataCell(Text('Low-medium water')),
            DataCell(Text('Tolerant to current metrics')),
          ]),
          DataRow(cells: [
            DataCell(Text('Jute')),
            DataCell(Text('N: Medium, P: Low, K: Medium')),
            DataCell(Text('High water')),
            DataCell(Text('Humid conditions preferred')),
          ]),
        ],
      ),
    );
  }
}
