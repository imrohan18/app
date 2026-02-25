import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Open settings
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _ProfileHeader(),
          const SizedBox(height: 24),
          const _SectionHeader('Account'),
          const SizedBox(height: 8),
          _ProfileOption(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {},
          ),
          _ProfileOption(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {},
          ),
          _ProfileOption(
            icon: Icons.language,
            title: 'Language',
            trailing: const Text(
              'English',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const _SectionHeader('Support'),
          const SizedBox(height: 8),
          _ProfileOption(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () {},
          ),
          _ProfileOption(
            icon: Icons.info_outline,
            title: 'About AgriSense',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF10B981),
                width: 3,
              ),
            ),
            child: const CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuD85KzWPxSuaTkBOgYuNoTostwSazfqSesZVgk6mvZv_ooqd1VGkEn-ORw4rr42C60pw4GTT0F18gM2UYrsHEYdQs6uA1iimVenCCYsC6nIh4b-ZBKj1P0mPsoCnGwXyLD-fJ1_2OZRPCeEltZdu3y0N81wtsp6sIwWaxKGgGNN2EKKP1eBo3_iozTqrm0kayI9tvEo-RND1h9eY3SuxWQ-Yznj45q6v_jGstlHMLNsi1JOOd6cQb13eYURlAeqAoYMoBUNUYlGBk-d',
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Farmer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'farmer@agrisense.ai',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Premium Member',
                    style: TextStyle(
                      color: Color(0xFF059669),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF94A3B8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF334155),
          ),
        ),
        trailing: trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
