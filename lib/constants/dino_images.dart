import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class DinoImages {
  static const Map<String, String> presetOptions = {
    'Tyrannosaurus Rex (Theropoda)': 'assets/Tyrannosaurus_Rex.jpg',
    'Velociraptor (Dromaeosauridae)': 'assets/Velociraptor_Mongoliensis.jpg',
    'Spinosaurus (Semi-Akuatik)': 'assets/Spinosaurus_Aegyptiacus.jpg',
    'Triceratops (Ceratopsia)': 'assets/Triceratops_Horridus.jpg',
    'Brachiosaurus (Sauropoda)': 'assets/Brachiosaurus_Altithorax.jpg',
    'Baryonyx (Spinosauridae)': 'assets/Baryonx.jpg',
    'Oviraptor (Oviraptoridae)': 'assets/Oviraptor_Philoceratops.jpg',
  };

  static const Map<String, String> _assetMap = {
    'tyrannosaurus': 'assets/Tyrannosaurus_Rex.jpg',
    't-rex': 'assets/Tyrannosaurus_Rex.jpg',
    'spinosaurus': 'assets/Spinosaurus_Aegyptiacus.jpg',
    'triceratops': 'assets/Triceratops_Horridus.jpg',
    'velociraptor': 'assets/Velociraptor_Mongoliensis.jpg',
    'brachiosaurus': 'assets/Brachiosaurus_Altithorax.jpg',
    'baryonx': 'assets/Baryonx.jpg',
    'baryonyx': 'assets/Baryonx.jpg',
    'oviraptor': 'assets/Oviraptor_Philoceratops.jpg',
  };

  static String getAssetPath(String dinoName, {String diet = 'Carnivora'}) {
    final clean = dinoName.trim().toLowerCase();

    for (final entry in _assetMap.entries) {
      if (clean.contains(entry.key)) return entry.value;
    }
    if (clean.contains('raptor') || clean.contains('dromaeo')) {
      return 'assets/Velociraptor_Mongoliensis.jpg';
    }
    if (clean.contains('ceratops') || clean.contains('tops')) {
      return 'assets/Triceratops_Horridus.jpg';
    }
    if (clean.contains('sauropod') || clean.contains('titan') || clean.contains('longus')) {
      return 'assets/Brachiosaurus_Altithorax.jpg';
    }

    switch (diet) {
      case 'Herbivora':
        return 'assets/Triceratops_Horridus.jpg';
      case 'Omnivora':
        return 'assets/Oviraptor_Philoceratops.jpg';
      case 'Carnivora':
      default:
        return 'assets/Tyrannosaurus_Rex.jpg';
    }
  }

  /// Menangani Base64 (Galeri), Direct Web URL (CORS Safe), dan Local Assets
  static Widget buildImage({
    required String? imageSource,
    required String dinoName,
    required String diet,
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.topCenter,
  }) {
    final effectiveSource = (imageSource != null && imageSource.trim().isNotEmpty)
        ? imageSource.trim()
        : getAssetPath(dinoName, diet: diet);

    // 1. Gambar dari Galeri (Base64)
    if (effectiveSource.startsWith('data:image')) {
      try {
        final commaIndex = effectiveSource.indexOf(',');
        final base64Data =
            commaIndex != -1 ? effectiveSource.substring(commaIndex + 1) : effectiveSource;
        final bytes = base64Decode(base64Data);
        return Image.memory(
          bytes,
          fit: fit,
          alignment: alignment,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            getAssetPath(dinoName, diet: diet),
            fit: fit,
            alignment: alignment,
          ),
        );
      } catch (e) {
        return Image.asset(
          getAssetPath(dinoName, diet: diet),
          fit: fit,
          alignment: alignment,
        );
      }
    }

    // 2. URL Internet Eksternal (Bypass CORS untuk Flutter Web)
    if (effectiveSource.startsWith('http://') || effectiveSource.startsWith('https://')) {
      final String safeUrl = kIsWeb
          ? 'https://images.weserv.nl/?url=${Uri.encodeComponent(effectiveSource)}&default=${Uri.encodeComponent(effectiveSource)}'
          : effectiveSource;

      return Image.network(
        safeUrl,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
            effectiveSource,
            fit: fit,
            alignment: alignment,
            errorBuilder: (ctx, err, stack) => Image.asset(
              getAssetPath(dinoName, diet: diet),
              fit: fit,
              alignment: alignment,
            ),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: AppColors.natGeoGreenDark,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryYellow,
                strokeWidth: 2,
              ),
            ),
          );
        },
      );
    }

    // 3. Asset Bawaan Lokal
    return Image.asset(
      effectiveSource,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.natGeoGreen,
        child: const Center(
          child: Icon(Icons.pets, size: 40, color: Colors.white30),
        ),
      ),
    );
  }
}