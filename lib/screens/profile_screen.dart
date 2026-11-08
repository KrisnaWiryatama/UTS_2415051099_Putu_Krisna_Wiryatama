import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('RESEARCHER STATION'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
        child: Column(
          children: [
            // 1. Kartu Utama Peneliti (Profile Card)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderSubtle),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Frame Foto Profil dengan Border Kuning Khas Nat Geo
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryYellow,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: AppColors.surfaceElevated,
                      backgroundImage: const AssetImage('Nyengir.jpg'),
                      child: ClipOval(
                        child: Image.asset(
                          'Nyengir.jpg',
                          width: 92,
                          height: 92,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.person,
                            size: 48,
                            color: AppColors.natGeoGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Nama Lengkap Peneliti
                  const Text(
                    'Putu Krisna Wiryatama',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Badge NIM & Kelas
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.natGeoGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'NIM: 2415051099 • PTI 5B',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.natGeoGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Institusi
                  const Text(
                    'Pendidikan Teknik Informatika • FTK\nUniversitas Pendidikan Ganesha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // 2. Ringkasan Aktivitas Lapangan (Expedition Metrics)
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    label: 'Status Ekspedisi',
                    value: 'Active',
                    icon: Icons.verified,
                    accentColor: AppColors.natGeoGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricTile(
                    label: 'Database Sync',
                    value: 'Supabase',
                    icon: Icons.cloud_done,
                    accentColor: const Color(0xFFE5A910),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // 3. Section Informasi Proyek & Sistem
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sistem & Observasi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: Icons.science_outlined,
                    title: 'Fokus Riset',
                    subtitle: 'Software Engineering & Mobile Exploration',
                  ),
                  const Divider(height: 1, indent: 56, color: AppColors.borderSubtle),
                  _buildSettingItem(
                    icon: Icons.storage_outlined,
                    title: 'Arsitektur Data',
                    subtitle: 'REST API Catalog & Supabase Logbook',
                  ),
                  const Divider(height: 1, indent: 56, color: AppColors.borderSubtle),
                  _buildSettingItem(
                    icon: Icons.devices_outlined,
                    title: 'Platform Target',
                    subtitle: 'Adaptive Layout (Web, Tablet & Mobile)',
                  ),
                  const Divider(height: 1, indent: 56, color: AppColors.borderSubtle),
                  _buildSettingItem(
                    icon: Icons.info_outline,
                    title: 'Aplikasi',
                    subtitle: 'Jurassica Nat Geo Kids v1.0.0',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu: Metric Box
  Widget _buildMetricTile({
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu: List Tile Item
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.natGeoGreen),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
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