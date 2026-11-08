import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsArticles = [
      {
        'title': 'Fosil Spinosaurus Baru Ditemukan di Gurun Sahara',
        'date': '07 Nov 2026',
        'category': 'Discovery',
        'summary':
            'Tim paleontologi gabungan mengumumkan temuan vertebrae ekor baru yang membuktikan kemampuan berenang predator air tawar raksasa ini.',
      },
      {
        'title': 'Rekonstruksi Suara Parasaurolophus Menggunakan CT Scan 3D',
        'date': '02 Nov 2026',
        'category': 'Research',
        'summary':
            'Peneliti berhasil menyimulasikan frekuensi getaran rongga mahkota kepala, menghasilkan resonansi suara rendah jarak jauh.',
      },
      {
        'title': 'Ekspedisi Fosil Formasi Hell Creek Musim Gugur Dimulai',
        'date': '28 Okt 2026',
        'category': 'Expedition',
        'summary':
            'Observasi lapisan batas Cretaceous-Paleogene untuk memetakan kepunahan massal dinosaurus non-unggas.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('JURASSICA NEWS'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: newsArticles.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = newsArticles[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.borderSubtle),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.natGeoGreen.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['category']!,
                          style: const TextStyle(
                            color: AppColors.natGeoGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        item['date']!,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['summary']!,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                      height: 1.35,
                    ),
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