import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:agrisense_fronted/l10n/app_localizations.dart';
import 'fertilizer_advisory.dart';
import 'soil_health_dashboard.dart';

class FieldsScreen extends StatelessWidget {
  const FieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.fieldsNav),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
          bottom: TabBar(
            labelColor: const Color(0xFF10B981),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF10B981),
            tabs: [
              Tab(text: l10n.myFields),
              Tab(text: l10n.healthCheck),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const _FieldsListTab(),
            const _HealthCheckTab(),
          ],
        ),
      ),
    );
  }
}

class _FieldsListTab extends StatelessWidget {
  const _FieldsListTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _FieldCard(
            name: 'North Acre',
            crop: 'Rice',
            location: '23.4°N, 88.2°E',
            status: 'Optimal',
            lastUpdated: '2 hours ago',
          ),
          SizedBox(height: 16),
          _FieldCard(
            name: 'River Plot',
            crop: 'Maize',
            location: '23.5°N, 88.3°E',
            status: 'Attention Needed',
            lastUpdated: '1 day ago',
            isWarning: true,
          ),
          SizedBox(height: 16),
          _FieldCard(
            name: 'South Garden',
            crop: 'Vegetables',
            location: '23.3°N, 88.1°E',
            status: 'Good',
            lastUpdated: '3 days ago',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Field feature coming soon')),
          );
        },
        backgroundColor: const Color(0xFF10B981),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _HealthCheckTab extends StatefulWidget {
  const _HealthCheckTab();

  @override
  State<_HealthCheckTab> createState() => _HealthCheckTabState();
}

class _HealthCheckTabState extends State<_HealthCheckTab> {
  final _nController = TextEditingController();
  final _pController = TextEditingController();
  final _kController = TextEditingController();
  final _phController = TextEditingController();
  final _ocController = TextEditingController();

  // Ideal values for Indian Soil
  final double idealN = 420;
  final double idealP = 20;
  final double idealK = 200;
  final double idealPh = 7.0;
  final double idealOc = 0.75;

  bool _showChart = false;

  @override
  void dispose() {
    _nController.dispose();
    _pController.dispose();
    _kController.dispose();
    _phController.dispose();
    _ocController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_nController.text.isNotEmpty &&
        _pController.text.isNotEmpty &&
        _kController.text.isNotEmpty &&
        _phController.text.isNotEmpty &&
        _ocController.text.isNotEmpty) {
      setState(() {
        _showChart = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.enterValue,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _InputRow(label: l10n.nitrogen, controller: _nController),
          _InputRow(label: l10n.phosphorus, controller: _pController),
          _InputRow(label: l10n.potassium, controller: _kController),
          _InputRow(label: l10n.pHLevel, controller: _phController),
          _InputRow(label: l10n.organicCarbon, controller: _ocController),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _calculate,
              child: Text(
                l10n.compare,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          if (_showChart) ...[
            const SizedBox(height: 32),
            Text(
              '${l10n.yourValue} vs ${l10n.ideal} (%)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 1.2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'N';
                              break;
                            case 1:
                              text = 'P';
                              break;
                            case 2:
                              text = 'K';
                              break;
                            case 3:
                              text = 'pH';
                              break;
                            case 4:
                              text = 'OC';
                              break;
                            default:
                              text = '';
                          }
                          return SideTitleWidget(
                            meta: meta,
                            space: 4,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String metric = '';
                        switch (group.x) {
                          case 0:
                            metric = 'N';
                            break;
                          case 1:
                            metric = 'P';
                            break;
                          case 2:
                            metric = 'K';
                            break;
                          case 3:
                            metric = 'pH';
                            break;
                          case 4:
                            metric = 'OC';
                            break;
                        }
                        return BarTooltipItem(
                          '$metric\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: '${rod.toY.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _makeGroupData(0, double.tryParse(_nController.text) ?? 0, idealN),
                    _makeGroupData(1, double.tryParse(_pController.text) ?? 0, idealP),
                    _makeGroupData(2, double.tryParse(_kController.text) ?? 0, idealK),
                    _makeGroupData(3, double.tryParse(_phController.text) ?? 0, idealPh),
                    _makeGroupData(4, double.tryParse(_ocController.text) ?? 0, idealOc),
                  ],
                ),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 16, height: 16, color: Colors.grey.shade300),
                const SizedBox(width: 8),
                Text(l10n.ideal),
                const SizedBox(width: 24),
                Container(width: 16, height: 16, color: const Color(0xFF10B981)),
                const SizedBox(width: 8),
                Text(l10n.yourValue),
              ],
            ),
          ],
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double current, double ideal) {
    // Calculate percentage of ideal
    double percentage = (current / ideal) * 100;
    // Cap visual bar at 200% to avoid chart scaling issues
    double visualY = percentage > 200 ? 200 : percentage;
    
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: 100, // Ideal is always 100%
          color: Colors.grey.shade300,
          width: 12,
        ),
        BarChartRodData(
          toY: visualY,
          color: const Color(0xFF10B981),
          width: 12,
        ),
      ],
    );
  }
}

class _InputRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _InputRow({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  final String name;
  final String crop;
  final String location;
  final String status;
  final String lastUpdated;
  final bool isWarning;

  const _FieldCard({
    required this.name,
    required this.crop,
    required this.location,
    required this.status,
    required this.lastUpdated,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.grass, color: Color(0xFF10B981)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        crop,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isWarning
                        ? Colors.amber.withValues(alpha: 0.1)
                        : Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isWarning ? Colors.amber[800] : Colors.green[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const Spacer(),
                Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Text(
                  lastUpdated,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SoilHealthDashboardScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bar_chart, size: 18),
                    label: const Text('Soil Health'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF10B981),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FertilizerAdvisoryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.science, size: 18),
                    label: const Text('Advisory'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF10B981),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
