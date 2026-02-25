import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/soil_state.dart';

class SoilHealthDashboardScreen extends StatelessWidget {
  const SoilHealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final idealN = 420.0;
    final idealP = 20.0;
    final idealK = 200.0;
    final idealPh = 7.0;
    final idealOc = 0.75;
    final s = SoilState.instance;
    final percents = <double>[
      _pct(s.n, idealN),
      _pct(s.p, idealP),
      _pct(s.k, idealK),
      _pct(s.ph, idealPh),
      _pct(s.oc, idealOc),
    ].map((e) => e.clamp(0, 200)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Soil Health Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: RadarChart(
                RadarChartData(
                  radarShape: RadarShape.polygon,
                  tickCount: 4,
                  ticksTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 10,
                  ),
                  radarBorderData: const BorderSide(color: Colors.transparent),
                  gridBorderData: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                  titlePositionPercentageOffset: 0.18,
                  getTitle: (index, angle) {
                    const labels = ['N','P','K','pH','OC'];
                    return RadarChartTitle(text: labels[index]);
                  },
                  dataSets: [
                    RadarDataSet(
                      dataEntries: const [
                        RadarEntry(value: 100),
                        RadarEntry(value: 100),
                        RadarEntry(value: 100),
                        RadarEntry(value: 100),
                        RadarEntry(value: 100),
                      ],
                      fillColor: Colors.grey.shade300,
                      borderColor: Colors.grey.shade400,
                      entryRadius: 0,
                      borderWidth: 2,
                    ),
                    RadarDataSet(
                      dataEntries: percents
                          .map((v) => RadarEntry(value: v as double))
                          .toList(),
                      fillColor: const Color(0xFF10B981).withValues(alpha: 0.25),
                      borderColor: const Color(0xFF10B981),
                      entryRadius: 2,
                      borderWidth: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _StatTile(
            title: 'Nitrogen',
            value: '70 ppm',
            status: 'Optimal',
            color: Colors.green,
          ),
          const _StatTile(
            title: 'Phosphorus',
            value: '30 ppm',
            status: 'Low',
            color: Colors.amber,
          ),
          const _StatTile(
            title: 'Potassium',
            value: '180 ppm',
            status: 'High',
            color: Colors.blue,
          ),
          const _StatTile(
            title: 'Soil pH',
            value: '6.5',
            status: 'Optimal',
            color: Colors.deepPurple,
          ),
          const _StatTile(
            title: 'Temperature',
            value: '28°C',
            status: 'Warm',
            color: Colors.red,
          ),
          const _StatTile(
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

double _pct(double current, double ideal) {
  if (ideal == 0) return 0;
  return (current / ideal) * 100;
}
