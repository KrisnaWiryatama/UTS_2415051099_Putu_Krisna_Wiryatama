import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import 'favorites_screen.dart';
import 'dino_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryYellow,
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/dinosaur_icon.jpg'),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'JURASSICA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Full Width
            Container(
              width: double.infinity,
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search specimens, eras...',
                  hintStyle:
                      TextStyle(color: AppColors.textMuted, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Kategori Pill Row (All Eras, Popular, Logbook)
            const Text(
              'Expeditions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildCategoryPill(
                    icon: Icons.public,
                    title: 'All Eras',
                    iconBgColor: Colors.white,
                    iconColor: AppColors.natGeoGreen,
                    cardBgColor: AppColors.natGeoGreen,
                    textColor: Colors.white,
                    isSelected: true,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCategoryPill(
                    icon: Icons.whatshot,
                    title: 'Popular',
                    iconBgColor: const Color(0xFFFF9800).withValues(alpha: 0.15),
                    iconColor: const Color(0xFFFF9800),
                    cardBgColor: Colors.white,
                    textColor: AppColors.textDark,
                    isSelected: false,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCategoryPill(
                    icon: Icons.bookmark,
                    title: 'Logbook',
                    iconBgColor: AppColors.primaryYellow.withValues(alpha: 0.3),
                    iconColor: AppColors.textDark,
                    cardBgColor: Colors.white,
                    textColor: AppColors.textDark,
                    isSelected: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section Kartu Dinosaurus Unggulan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Featured Discovery',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.natGeoGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Horizontal Scroll Cards
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  _buildFeaturedCard(
                    context: context,
                    cardColor: AppColors.natGeoGreen,
                    specimenName: 'Spinosaurus Aegyptiacus',
                    originEra: 'Cretaceous Period • North Africa',
                    specimenCount: '12 Fossils',
                    durationEstimate: '95 Mya',
                    illustrationIcon: Icons.water,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DinoDetailScreen(
                            dinoName: 'Spinosaurus Aegyptiacus',
                            era: 'Late Cretaceous',
                            diet: 'Piscivore / Carnivore',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  _buildFeaturedCard(
                    context: context,
                    cardColor: const Color(0xFFE5A910),
                    specimenName: 'Tyrannosaurus Rex',
                    originEra: 'Late Cretaceous • Laramidia',
                    specimenCount: '30 Specimens',
                    durationEstimate: '68 Mya',
                    illustrationIcon: Icons.pets,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DinoDetailScreen(
                            dinoName: 'Tyrannosaurus Rex',
                            era: 'Late Cretaceous',
                            diet: 'Carnivore',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill({
    required IconData icon,
    required String title,
    required Color iconBgColor,
    required Color iconColor,
    required Color cardBgColor,
    required Color textColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(30),
          border: isSelected
              ? null
              : Border.all(color: AppColors.borderSubtle, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard({
    required BuildContext context,
    required Color cardColor,
    required String specimenName,
    required String originEra,
    required String specimenCount,
    required String durationEstimate,
    required IconData illustrationIcon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 210,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: cardColor.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  illustrationIcon,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Text(
              specimenName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              originEra,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 11,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                _buildStatBadge(Icons.description, specimenCount),
                const SizedBox(width: 8),
                _buildStatBadge(Icons.schedule, durationEstimate),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}