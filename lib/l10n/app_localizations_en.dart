// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AgriSense';

  @override
  String get loginButton => 'Sign In';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get emailHint => 'farmer@agrisense.ai';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get homeNav => 'Home';

  @override
  String get analysisNav => 'Analysis';

  @override
  String get fieldsNav => 'Fields';

  @override
  String get profileNav => 'Profile';

  @override
  String get soilHealth => 'Soil Health';

  @override
  String get advisory => 'Advisory';

  @override
  String get checkSoilHealth => 'Check Soil Health';

  @override
  String get myFields => 'My Fields';

  @override
  String get healthCheck => 'Health Check';

  @override
  String get nitrogen => 'Nitrogen (N)';

  @override
  String get phosphorus => 'Phosphorus (P)';

  @override
  String get potassium => 'Potassium (K)';

  @override
  String get pHLevel => 'pH Level';

  @override
  String get organicCarbon => 'Organic Carbon';

  @override
  String get compare => 'Compare';

  @override
  String get ideal => 'Ideal';

  @override
  String get yourValue => 'Your Value';

  @override
  String get enterValue => 'Enter value';
}
