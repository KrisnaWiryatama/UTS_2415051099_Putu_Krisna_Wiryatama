import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../constants/dino_images.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';
import '../widgets/add_specimen_dialog.dart';
import '../widgets/edit_specimen_dialog.dart';
import '../widgets/report_feedback_dialog.dart';
import '../widgets/state_feedback_widget.dart';
import 'dino_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const Color carnivoreColor = Color(0xFFD32F2F);
  static const Color herbivoreColor = Color(0xFF2E7D32);
  static const Color omnivoreColor = Color(0xFF1976D2);

  Color _getDietColor(String diet) {
    switch (diet) {
      case 'Carnivora':
        return carnivoreColor;
      case 'Herbivora':
        return herbivoreColor;
      case 'Omnivora':
        return omnivoreColor;
      default:
        return AppColors.textDark;
    }
  }

  void _showDeleteConfirmation(BuildContext context, DinoSpecimen dino) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hapus Spesimen?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus arsip "${dino.name}" dari server Supabase? Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('BATAL', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await context.read<DinoCatalogProvider>().deleteSpecimen(dino.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red.shade700,
                      content: Text('Arsip "${dino.name}" berhasil dihapus.'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black87,
                      content: Text('Gagal menghapus: $e'),
                    ),
                  );
                }
              }
            },
            child: const Text('HAPUS'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = context.watch<DinoCatalogProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('SPECIES ARCHIVE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Arsip',
            onPressed: () => catalogProvider.loadDataFromSupabase(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Box & Tombol Tambah Spesimen
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: TextField(
                      onChanged: (val) => catalogProvider.setSearchQuery(val),
                      decoration: const InputDecoration(
                        hintText: 'Cari nama spesimen atau era...',
                        hintStyle: TextStyle(fontSize: 13, color: AppColors.textMuted),
                        prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddSpecimenScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.textDark,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filter Kategori Diet
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildDietFilterChip(
                  context,
                  label: 'Carnivora',
                  icon: Icons.pets,
                  color: carnivoreColor,
                  isSelected: catalogProvider.selectedDiet == 'Carnivora',
                ),
                const SizedBox(width: 8),
                _buildDietFilterChip(
                  context,
                  label: 'Herbivora',
                  icon: Icons.eco,
                  color: herbivoreColor,
                  isSelected: catalogProvider.selectedDiet == 'Herbivora',
                ),
                const SizedBox(width: 8),
                _buildDietFilterChip(
                  context,
                  label: 'Omnivora',
                  icon: Icons.lunch_dining,
                  color: omnivoreColor,
                  isSelected: catalogProvider.selectedDiet == 'Omnivora',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Konten Spesimen Responsif
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (catalogProvider.isLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.natGeoGreen),
                        SizedBox(height: 12),
                        Text(
                          'Menghubungkan ke server arsip...',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (catalogProvider.errorMessage != null) {
                  return StateFeedbackWidget.error(
                    message: catalogProvider.errorMessage!,
                    onRetry: () => catalogProvider.loadDataFromSupabase(),
                  );
                }

                if (catalogProvider.filteredSpecimens.isEmpty) {
                  return StateFeedbackWidget.empty(
                    message: catalogProvider.searchQuery.isNotEmpty
                        ? 'Tidak ditemukan spesimen dengan kata kunci "${catalogProvider.searchQuery}" pada kategori ${catalogProvider.selectedDiet}.'
                        : 'Belum ada data spesimen untuk kategori ${catalogProvider.selectedDiet}.',
                    onReset: () {
                      catalogProvider.setSearchQuery('');
                      catalogProvider.setSelectedDiet('Semua');
                    },
                  );
                }

                final specimens = catalogProvider.filteredSpecimens;
                final bool isWide = constraints.maxWidth >= 600;

                if (isWide) {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.85,
                    ),
                    itemCount: specimens.length,
                    itemBuilder: (context, index) {
                      return _buildSpecimenCard(
                          context, specimens[index], catalogProvider);
                    },
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                  itemCount: specimens.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildSpecimenCard(
                        context, specimens[index], catalogProvider);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietFilterChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
  }) {
    final provider = context.read<DinoCatalogProvider>();
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          provider.setSelectedDiet(isSelected ? 'Semua' : label);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? color : AppColors.borderSubtle,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? Colors.white : AppColors.textDark,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecimenCard(
    BuildContext context,
    DinoSpecimen dino,
    DinoCatalogProvider provider,
  ) {
    final bool isDefaultSeed = [
      'tyrannosaurus rex',
      'spinosaurus aegyptiacus',
      'velociraptor mongoliensis',
      'triceratops horridus',
      'brachiosaurus altithorax',
    ].contains(dino.name.trim().toLowerCase());

    final bool isMine = provider.isMySpecimen(dino.id) || !isDefaultSeed;
    final Color dietColor = _getDietColor(dino.diet);

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isMine
              ? AppColors.primaryYellow.withValues(alpha: 0.8)
              : AppColors.borderSubtle,
          width: isMine ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DinoDetailScreen(
                dino: dino,
                dinoName: dino.name,
                era: dino.era,
                diet: dino.diet,
                description: dino.description,
                length: dino.length,
                weight: dino.weight,
                discoveredIn: dino.discoveredIn,
                likeCount: dino.likeCount,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 78,
                      height: 78,
                      child: DinoImages.buildImage(
                        imageSource: dino.imageUrl,
                        dinoName: dino.name,
                        diet: dino.diet,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                dino.name,
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            if (isMine)
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryYellow.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.primaryYellow,
                                    width: 0.8,
                                  ),
                                ),
                                child: const Text(
                                  'ARSIP SAYA',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          dino.era,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: dietColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                dino.diet,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: dietColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.straighten,
                                size: 12, color: AppColors.textMuted),
                            const SizedBox(width: 3),
                            Text(
                              dino.length,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,
                        color: AppColors.textMuted, size: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditSpecimenScreen(specimen: dino),
                          ),
                        );
                      } else if (value == 'delete') {
                        _showDeleteConfirmation(context, dino);
                      } else if (value == 'feedback') {
                        showDialog(
                          context: context,
                          builder: (context) => ReportFeedbackDialog(
                            specimen: dino,
                            type: 'feedback',
                          ),
                        );
                      } else if (value == 'report') {
                        showDialog(
                          context: context,
                          builder: (context) => ReportFeedbackDialog(
                            specimen: dino,
                            type: 'report',
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        if (isMine) ...[
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_outlined,
                                    size: 18, color: AppColors.natGeoGreen),
                                SizedBox(width: 8),
                                Text(
                                  'Edit Spesimen',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.natGeoGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline,
                                    size: 18, color: Colors.red.shade700),
                                const SizedBox(width: 8),
                                Text(
                                  'Hapus Data',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const PopupMenuItem(
                          value: 'feedback',
                          child: Row(
                            children: [
                              Icon(Icons.rate_review_outlined,
                                  size: 18, color: AppColors.textDark),
                              SizedBox(width: 8),
                              Text('Beri Masukan', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'report',
                          child: Row(
                            children: [
                              Icon(Icons.flag_outlined,
                                  size: 18, color: Colors.orange),
                              SizedBox(width: 8),
                              Text('Laporkan Data', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text(
                dino.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, color: AppColors.borderSubtle),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: provider.isBookmarked(dino.id)
                        ? AppColors.natGeoGreen
                        : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        provider.toggleBookmark(dino.id);
                        final isAdded = provider.isBookmarked(dino.id);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                            backgroundColor: isAdded
                                ? AppColors.natGeoGreen
                                : AppColors.textDark,
                            content: Text(
                              isAdded
                                  ? 'Disimpan ke Logbook Ekspedisi'
                                  : 'Dihapus dari Logbook Ekspedisi',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              provider.isBookmarked(dino.id)
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 14,
                              color: provider.isBookmarked(dino.id)
                                  ? Colors.white
                                  : AppColors.textDark,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Logbook',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: provider.isBookmarked(dino.id)
                                    ? Colors.white
                                    : AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () async {
                        await provider.toggleLike(dino.id);
                        if (context.mounted) {
                          final isLikedNow = provider.isLiked(dino.id);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 900),
                              backgroundColor: isLikedNow
                                  ? Colors.red.shade700
                                  : AppColors.textDark,
                              content: Text(
                                isLikedNow
                                    ? 'Menyukai spesimen ${dino.name}'
                                    : 'Batal menyukai spesimen',
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              provider.isLiked(dino.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 15,
                              color: provider.isLiked(dino.id)
                                  ? Colors.red
                                  : AppColors.textDark,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${dino.likeCount} Suka',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: provider.isLiked(dino.id)
                                    ? Colors.red.shade800
                                    : AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}