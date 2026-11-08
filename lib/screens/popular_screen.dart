import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';
import 'dino_detail_screen.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DinoCatalogProvider>();
    final popularList = provider.popularSpecimens;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('MOST POPULAR SPECIES'),
      ),
      body: Column(
        children: [
          // Banner Info Peringkat Populer
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFF9800).withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF9800),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.whatshot, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Papan Peringkat Spesimen',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Daftar dinosaurus terpopuler berdasarkan akumulasi suara suka dari seluruh peneliti lapangan.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textMuted,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // List Ranking
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: popularList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final dino = popularList[index];
                final int rank = index + 1;
                final bool isUserLiked = provider.isLiked(dino.id);

                return _buildPopularRankCard(
                  context: context,
                  dino: dino,
                  rank: rank,
                  isUserLiked: isUserLiked,
                  onLikeTap: () => provider.toggleLike(dino.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularRankCard({
    required BuildContext context,
    required DinoSpecimen dino,
    required int rank,
    required bool isUserLiked,
    required VoidCallback onLikeTap,
  }) {
    // Penentuan warna label diet
    Color dietColor;
    IconData dietIcon;
    if (dino.diet == 'Carnivora') {
      dietColor = AppColors.eraCretaceous;
      dietIcon = Icons.pets;
    } else if (dino.diet == 'Herbivora') {
      dietColor = AppColors.natGeoGreen;
      dietIcon = Icons.grass;
    } else {
      dietColor = const Color(0xFFE5A910);
      dietIcon = Icons.lunch_dining;
    }

    // Warna medali untuk Top 3
    Color rankBadgeColor = AppColors.surfaceElevated;
    Color rankTextColor = AppColors.textMuted;
    if (rank == 1) {
      rankBadgeColor = const Color(0xFFFFD700); // Emas
      rankTextColor = const Color(0xFF5D4037);
    } else if (rank == 2) {
      rankBadgeColor = const Color(0xFFC0C0C0); // Perak
      rankTextColor = AppColors.textDark;
    } else if (rank == 3) {
      rankBadgeColor = const Color(0xFFCD7F32); // Perunggu
      rankTextColor = Colors.white;
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: rank <= 3
              ? rankBadgeColor.withValues(alpha: 0.5)
              : AppColors.borderSubtle,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DinoDetailScreen(
                dinoName: dino.name,
                era: dino.era,
                diet: dino.diet,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              // Badge Nomor Urut Ranking
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: rankBadgeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      color: rankTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Detail Spesimen & Label Badge Diet
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dino.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        // Badge Label Kategori Spesies Diet
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: dietColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: dietColor.withValues(alpha: 0.4),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(dietIcon, size: 11, color: dietColor),
                              const SizedBox(width: 4),
                              Text(
                                dino.diet,
                                style: TextStyle(
                                  color: dietColor,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            dino.era,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tombol Interaktif Suka & Angka Vote Counter
              InkWell(
                onTap: onLikeTap,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: isUserLiked
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isUserLiked ? Icons.favorite : Icons.favorite_border,
                        color: isUserLiked ? Colors.red : AppColors.textMuted,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${dino.likeCount}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isUserLiked ? Colors.red : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}