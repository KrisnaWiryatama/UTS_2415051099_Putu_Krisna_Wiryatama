import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class DinoDetailScreen extends StatelessWidget {
  final String dinoName;
  final String era;
  final String diet;

  const DinoDetailScreen({
    super.key,
    this.dinoName = 'Tyrannosaurus Rex',
    this.era = 'Late Cretaceous',
    this.diet = 'Carnivore',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dinoName.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: const Center(
                child: Icon(Icons.pets, size: 64, color: AppColors.primaryYellow),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              dinoName,
              style: const TextStyle(
                color: AppColors.textLight,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$diet • $era',
              style: const TextStyle(color: AppColors.primaryYellow, fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.borderSubtle),
            const SizedBox(height: 12),
            const Text(
              'DESKRIPSI SPESIMEN PALEONTOLOGI',
              style: TextStyle(
                color: AppColors.textLight,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Detail taksonomi, dimensi fisik, dan catatan fosil dari REST API akan ditampilkan lengkap di sini.',
              style: TextStyle(color: AppColors.textMuted, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}