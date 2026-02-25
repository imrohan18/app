import 'package:flutter/material.dart';
import 'package:agrisense_fronted/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = const Color(0xFFEC5B13);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AgriSense',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 12),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.eco, color: primary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: primary.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x338B5CF6),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAxSxDF29QjJyW76CK-OcBM5cqiDCgRFmS0p6ouu6HNRDUsAWv-7rTMiTEYXTjIu8713aqA8szzZ1WEi_Vb6PU-OUZNJz5dcQrsmb70zzUiUEAD8ZnmInk2rPWdmPzunOAEH1Rv2d7nhKQ-L3HlWJk25aRDtilEqN1bcOjM0CQ6OSQhOFlaSZiBq4RjwBjsJ2iRFJMrscP9hyHzY3blwxeIVTJyXoQ2CnHgic3H5YaaWEF7QewIJX9S16_WDUgJ80Ip2YhnIHyq6Ku',
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nano Banana says:',
                            style: TextStyle(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Welcome back! Ready to check your soil?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: primary, width: 2),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.transparent, width: 2),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _LabeledField(
                label: l10n.emailLabel,
                hint: l10n.emailHint,
                icon: Icons.mail,
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              _PasswordField(primary: primary),
              const SizedBox(height: 8),
              Row(
                children: [
                  _Checkbox(),
                  const SizedBox(width: 8),
                  const Text(
                    'Keep me logged in',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(
                    l10n.loginButton,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDrX46VcVJLvEJC9uyv1beS__X2ZIk8O4R0Iov8ky4wF1J9XKApwph17pzgg6v-kWuDsuv8xhCa1L33oAgAaYke0dW-jpQmttW3NjUwjRlYYhI931Lchztx65G9QI5f9kyCkeEKzuFv-IlQCgksOLlwV3hS9OUgoHdbVWYJYJbpD2ODdUEFIXhKREUDEa2ftj2zfEOWLEwvZ_nPFFR2o-On8mL1fSuqa8_F5z3Dd-M11y6KwjvTHTbQHCcwSSs1ebNAF2VPi4SdGaZj',
                        width: 20,
                        height: 20,
                      ),
                      label: const Text('Google'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple),
                      label: const Text('Apple'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  const Text(
                    'New to AgriSense? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 16,
                    children: const [
                      Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        'Terms of Service',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboard;
  const _LabeledField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.keyboard,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          keyboardType: keyboard,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  final Color primary;
  const _PasswordField({required this.primary});
  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.passwordLabel,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot?',
                  style: TextStyle(color: widget.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: _obscure,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
            hintText: 'Enter your password',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _Checkbox extends StatefulWidget {
  @override
  State<_Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<_Checkbox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => value = !value),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade400, width: 2),
          color: value ? Colors.orange : Colors.transparent,
        ),
        child: value
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : const SizedBox.shrink(),
      ),
    );
  }
}
