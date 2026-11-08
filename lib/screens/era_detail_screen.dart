import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/era_detail.dart';
import 'dino_detail_screen.dart';

class EraDetailScreen extends StatelessWidget {
  final EraDetailData era;
  final Color themeColor;
  final IconData icon;

  const EraDetailScreen({
    super.key,
    required this.era,
    required this.themeColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('${era.name.toUpperCase()} ARCHIVE'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner Era
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: themeColor.withValues(alpha: 0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: themeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: themeColor, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          era.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          era.timeline,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Ringkasan Era
            const Text(
              'IKHTISAR PERIODE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Text(
                era.summary,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Informasi Ekosistem (Grid Kondisi Alam & Iklim)
            const Text(
              'KONDISI BIOSFER & ALAM',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              icon: Icons.thermostat,
              title: 'Kondisi Iklim Global',
              description: era.climate,
              iconColor: Colors.deepOrange,
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              icon: Icons.public,
              title: 'Formasi Geografi & Daratan',
              description: era.geography,
              iconColor: Colors.teal,
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              icon: Icons.forest,
              title: 'Vegetasi & Kehidupan Flora',
              description: era.flora,
              iconColor: AppColors.natGeoGreen,
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              icon: Icons.history_edu,
              title: 'Peristiwa Besar & Transisi',
              description: era.landmarkEvent,
              iconColor: const Color(0xFF673AB7),
            ),
            const SizedBox(height: 20),

            // Spesies Kunci & Navigasi ke Detail Spesimen
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SPESIES IKONIK ERA INI',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  '${era.keyDinos.length} Spesimen Tercatat',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: era.keyDinos.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final dino = era.keyDinos[index];
                return _buildDinoListItem(context, dino);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
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

  Widget _buildDinoListItem(BuildContext context, EraDinoInfo dino) {
    Color dietColor;
    if (dino.diet == 'Carnivora') {
      dietColor = AppColors.eraCretaceous;
    } else if (dino.diet == 'Herbivora') {
      dietColor = AppColors.natGeoGreen;
    } else {
      dietColor = const Color(0xFFE5A910);
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          // Navigasi langsung ke halaman Detail Dinosaurus
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DinoDetailScreen(
                dinoName: dino.name,
                era: era.name,
                diet: dino.diet,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: dietColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  dino.diet == 'Carnivora'
                      ? Icons.pets
                      : dino.diet == 'Herbivora'
                          ? Icons.grass
                          : Icons.lunch_dining,
                  color: dietColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dino.name,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${dino.role} • ${dino.diet}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: dietColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dino.brief,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}