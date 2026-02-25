import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/fertilizer_advisory.dart';
import 'screens/crop_analysis.dart';
import 'screens/soil_health_dashboard.dart';
import 'screens/fields.dart';
import 'screens/profile.dart';

import 'package:agrisense_fronted/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/settings.dart';

void main() {
  runApp(const AgrisenseApp());
}

class ThemeController extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system;
  void setMode(ThemeMode newMode) {
    if (mode == newMode) return;
    mode = newMode;
    notifyListeners();
  }
}

final themeController = ThemeController();

class AgrisenseApp extends StatelessWidget {
  const AgrisenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      themeMode: themeController.mode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'sans-serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'sans-serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B1215),
          foregroundColor: Colors.white,
          elevation: 0.5,
        ),
        scaffoldBackgroundColor: const Color(0xFF0B1215),
      ),
      home: const _Shell(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/advisory': (_) => const FertilizerAdvisoryScreen(),
        '/crop-analysis': (_) => const CropAnalysisScreen(),
        '/soil-health': (_) => const SoilHealthDashboardScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
      },
    );
  }
}

class _Shell extends StatefulWidget {
  const _Shell({super.key});

  @override
  State<_Shell> createState() => _ShellState();
}

class _ShellState extends State<_Shell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screens = [
      const HomeScreen(),
      CropAnalysisScreen(
        onCheckSoilHealth: () => setState(() => _index = 2),
      ),
      const FieldsScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: KeyedSubtree(
          key: ValueKey(_index),
          child: screens[_index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _index = 1);
        },
        backgroundColor: Colors.orange.shade600,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 84,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 8,
          notchMargin: 8,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            StadiumBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavItem(
                  label: l10n.homeNav,
                  icon: Icons.home,
                  selected: _index == 0,
                  onTap: () => setState(() => _index = 0),
                ),
                _NavItem(
                  label: l10n.analysisNav,
                  icon: Icons.analytics,
                  selected: _index == 1,
                  activeColor: Colors.orange.shade600,
                  onTap: () => setState(() => _index = 1),
                ),
                const SizedBox(width: 56),
                _NavItem(
                  label: l10n.fieldsNav,
                  icon: Icons.public,
                  selected: _index == 2,
                  onTap: () => setState(() => _index = 2),
                ),
                _NavItem(
                  label: l10n.profileNav,
                  icon: Icons.person,
                  selected: _index == 3,
                  onTap: () => setState(() => _index = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color? activeColor;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? (activeColor ?? Theme.of(context).colorScheme.primary)
        : Colors.grey.shade400;
    return SizedBox(
      width: 68,
      height: 56,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
