import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';
import 'dino_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('SPECIES ARCHIVE'),
      ),
      body: Column(
        children: [
          // 1. Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderSubtle),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) =>
                    context.read<DinoCatalogProvider>().setSearchQuery(value),
                decoration: const InputDecoration(
                  hintText: 'Cari nama spesimen atau era...',
                  hintStyle: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // 2. Kategori Diet Tabs
          Consumer<DinoCatalogProvider>(
            builder: (context, provider, _) {
              final selectedDiet = provider.selectedDiet;
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 6.0),
                child: Row(
                  children: [
                    _buildDietTab(
                      context,
                      label: 'Carnivora',
                      icon: Icons.pets,
                      activeColor: AppColors.eraCretaceous,
                      isSelected: selectedDiet == 'Carnivora',
                    ),
                    const SizedBox(width: 8),
                    _buildDietTab(
                      context,
                      label: 'Herbivora',
                      icon: Icons.grass,
                      activeColor: AppColors.natGeoGreen,
                      isSelected: selectedDiet == 'Herbivora',
                    ),
                    const SizedBox(width: 8),
                    _buildDietTab(
                      context,
                      label: 'Omnivora',
                      icon: Icons.lunch_dining,
                      activeColor: const Color(0xFFE5A910),
                      isSelected: selectedDiet == 'Omnivora',
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 6),

          // 3. List Kartu Spesimen Reaktif
          Expanded(
            child: Consumer<DinoCatalogProvider>(
              builder: (context, provider, _) {
                final filteredList = provider.filteredSpecimens;

                if (filteredList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.travel_explore,
                          size: 56,
                          color: AppColors.textMuted.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Tidak ada spesimen ditemukan',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final dino = filteredList[index];
                    return _buildSpecimenCard(context, provider, dino);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietTab(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color activeColor,
    required bool isSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => context.read<DinoCatalogProvider>().setDiet(label),
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? activeColor : AppColors.borderSubtle,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecimenCard(
      BuildContext context, DinoCatalogProvider provider, DinoSpecimen dino) {
    Color badgeColor;
    if (dino.diet == 'Carnivora') {
      badgeColor = AppColors.eraCretaceous;
    } else if (dino.diet == 'Herbivora') {
      badgeColor = AppColors.natGeoGreen;
    } else {
      badgeColor = const Color(0xFFE5A910);
    }

    final bool isLiked = provider.isLiked(dino.id);
    final bool isBookmarked = provider.isBookmarked(dino.id);
    final int currentLikes = dino.likeCount;

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Konten Atas: Tap untuk buka Detail
            InkWell(
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
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          dino.diet == 'Carnivora'
                              ? Icons.pets
                              : dino.diet == 'Herbivora'
                                  ? Icons.grass
                                  : Icons.lunch_dining,
                          color: badgeColor,
                          size: 22,
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              dino.era,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert,
                            color: AppColors.textMuted),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onSelected: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 1000),
                              content:
                                  Text('Menu $value dipilih untuk ${dino.name}'),
                            ),
                          );
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit,
                                    size: 18, color: AppColors.natGeoGreen),
                                SizedBox(width: 8),
                                Text('Edit Spesimen'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'Hapus',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline,
                                    size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Hapus Data'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    dino.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textDark,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.straighten,
                              size: 14, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            dino.length,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.scale,
                              size: 14, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            dino.weight,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.place,
                              size: 13, color: AppColors.textMuted),
                          const SizedBox(width: 3),
                          Text(
                            dino.discoveredIn,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 18, color: AppColors.borderSubtle),

            // Baris Aksi Bawah: Langsung membaca state provider
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 1. Tombol Logbook
                InkWell(
                  onTap: () {
                    provider.toggleBookmark(dino.id);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: isBookmarked
                            ? const Color(0xFF616161)
                            : AppColors.primaryYellow,
                        duration: const Duration(milliseconds: 1200),
                        content: Row(
                          children: [
                            Icon(
                              isBookmarked
                                  ? Icons.bookmark_remove_outlined
                                  : Icons.bookmark_added,
                              color: isBookmarked
                                  ? Colors.white
                                  : AppColors.textDark,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                isBookmarked
                                    ? '${dino.name} dihapus dari Logbook'
                                    : '${dino.name} disimpan ke Logbook',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isBookmarked
                                      ? Colors.white
                                      : AppColors.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isBookmarked
                          ? AppColors.primaryYellow.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          size: 20,
                          color: isBookmarked
                              ? AppColors.primaryYellow
                              : AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isBookmarked ? 'Tersimpan' : 'Logbook',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isBookmarked
                                ? AppColors.primaryYellow
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // 2. Tombol Suka / Like
                InkWell(
                  onTap: () {
                    provider.toggleLike(dino.id);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: isLiked
                            ? const Color(0xFF555555)
                            : const Color(0xFFE53935),
                        duration: const Duration(milliseconds: 1200),
                        content: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite_border : Icons.favorite,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                isLiked
                                    ? 'Batal menyukai ${dino.name}'
                                    : 'Menyukai ${dino.name} (Masuk ke Popular)',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isLiked
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isLiked ? Colors.red : AppColors.textMuted,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$currentLikes Suka',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isLiked ? Colors.red : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}