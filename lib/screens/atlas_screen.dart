import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class AtlasScreen extends StatelessWidget {
  const AtlasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eras = [
      {
        'name': 'Triassic Period',
        'span': '252 - 201 Juta Tahun Lalu',
        'badgeColor': AppColors.eraTriassic,
        'icon': Icons.bolt,
        'summary':
            'Awal kemunculan dinosaurus pertama setelah kepunahan massal Permian. Iklim didominasi daratan kering superbenua Pangea.',
        'specimens': 'Coelophysis, Plateosaurus, Herrerasaurus',
      },
      {
        'name': 'Jurassic Period',
        'span': '201 - 145 Juta Tahun Lalu',
        'badgeColor': AppColors.eraJurassic,
        'icon': Icons.grass,
        'summary':
            'Masa keemasan sauropoda berleher panjang raksasa dan vegetasi tumbuhan paku raksasa yang rimbun di seluruh benua.',
        'specimens': 'Brachiosaurus, Stegosaurus, Allosaurus',
      },
      {
        'name': 'Cretaceous Period',
        'span': '145 - 66 Juta Tahun Lalu',
        'badgeColor': AppColors.eraCretaceous,
        'icon': Icons.local_fire_department,
        'summary':
            'Era puncak keragaman predator apex dan dinosaurus bertanduk, sebelum hantaman asteroid memicu kepunahan massal K-Pg.',
        'specimens': 'Tyrannosaurus Rex, Spinosaurus, Triceratops',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('GEOLOGICAL ATLAS'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: eras.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final era = eras[index];
          final Color badgeColor = era['badgeColor'] as Color;

          return Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.borderSubtle),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          era['icon'] as IconData,
                          color: badgeColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              era['name'] as String,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              era['span'] as String,
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
                  const SizedBox(height: 12),
                  Text(
                    era['summary'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textDark,
                      height: 1.4,
                    ),
                  ),
                  const Divider(height: 20, color: AppColors.borderSubtle),
                  Row(
                    children: [
                      const Icon(
                        Icons.fingerprint,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Koleksi: ${era['specimens']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.natGeoGreen,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}