import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';
import '../widgets/add_specimen_dialog.dart';
import '../widgets/edit_specimen_dialog.dart';
import '../widgets/report_feedback_dialog.dart';
import 'dino_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  // Warna diet lokal tanpa perlu mengedit app_theme.dart
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

  IconData _getDietIcon(String diet) {
    switch (diet) {
      case 'Carnivora':
        return Icons.pets;
      case 'Herbivora':
        return Icons.eco;
      case 'Omnivora':
        return Icons.lunch_dining;
      default:
        return Icons.category;
    }
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
          // 1. Search Box & Tombol Kuning Create
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                        hintStyle: TextStyle(
                            fontSize: 13, color: AppColors.textMuted),
                        prefixIcon:
                            Icon(Icons.search, color: AppColors.textMuted),
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
                      showDialog(
                        context: context,
                        builder: (context) => const AddSpecimenDialog(),
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

          // 2. Filter Kategori Diet
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

          // 3. Daftar Spesimen
          Expanded(
            child: catalogProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.natGeoGreen,
                    ),
                  )
                : catalogProvider.filteredSpecimens.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada spesimen yang cocok dengan pencarian.',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        itemCount: catalogProvider.filteredSpecimens.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final dino =
                              catalogProvider.filteredSpecimens[index];
                          return _buildSpecimenCard(
                              context, dino, catalogProvider);
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
    final bool isMine = provider.isMySpecimen(dino.id);
    final Color dietColor = _getDietColor(dino.diet);
    final IconData dietIcon = _getDietIcon(dino.diet);

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
                dinoName: dino.name,
                era: dino.era,
                diet: dino.diet,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      color: dietColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(dietIcon, color: dietColor),
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
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryYellow
                                      .withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.primaryYellow,
                                    width: 0.8,
                                  ),
                                ),
                                child: const Text(
                                  'ARSIP SAYA',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dino.era,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Menu Titik Tiga Adaptif
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,
                        color: AppColors.textMuted, size: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              EditSpecimenDialog(specimen: dino),
                        );
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
                        if (isMine)
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
                        const PopupMenuItem(
                          value: 'feedback',
                          child: Row(
                            children: [
                              Icon(Icons.rate_review_outlined,
                                  size: 18, color: AppColors.textDark),
                              SizedBox(width: 8),
                              Text('Beri Masukan',
                                  style: TextStyle(fontSize: 13)),
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
                              Text('Laporkan Data',
                                  style: TextStyle(fontSize: 13)),
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
                  fontSize: 12.5,
                  height: 1.4,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.straighten,
                      size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    dino.length,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.scale_outlined,
                      size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    dino.weight,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      dino.discoveredIn,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: AppColors.borderSubtle),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.bookmark_border,
                            size: 14, color: AppColors.textDark),
                        SizedBox(width: 4),
                        Text(
                          'Logbook',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => provider.incrementLike(dino.id),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_border,
                              size: 15, color: AppColors.textDark),
                          const SizedBox(width: 4),
                          Text(
                            '${dino.likeCount} Suka',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
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
      ),
    );
  }
}