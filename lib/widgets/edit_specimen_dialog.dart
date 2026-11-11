import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../constants/dino_images.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';

class EditSpecimenScreen extends StatefulWidget {
  final DinoSpecimen specimen;

  const EditSpecimenScreen({super.key, required this.specimen});

  @override
  State<EditSpecimenScreen> createState() => _EditSpecimenScreenState();
}

class _EditSpecimenScreenState extends State<EditSpecimenScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _eraController;
  late final TextEditingController _discoveredInController;
  late final TextEditingController _lengthController;
  late final TextEditingController _weightController;
  late final TextEditingController _descController;
  late final TextEditingController _customUrlController;

  late String _selectedDiet;
  late String _selectedPresetAsset;
  late String _imageMode; // 'gallery', 'preset', atau 'url'
  String? _galleryBase64Image;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final s = widget.specimen;
    _nameController = TextEditingController(text: s.name);
    _eraController = TextEditingController(text: s.era);
    _discoveredInController = TextEditingController(text: s.discoveredIn);
    _lengthController = TextEditingController(text: s.length);
    _weightController = TextEditingController(text: s.weight);
    _descController = TextEditingController(text: s.description);

    _selectedDiet = s.diet;

    final rawImage = s.imageUrl ?? '';
    if (rawImage.startsWith('data:image')) {
      _imageMode = 'gallery';
      _galleryBase64Image = rawImage;
      _selectedPresetAsset = 'assets/Tyrannosaurus_Rex.jpg';
      _customUrlController = TextEditingController();
    } else if (rawImage.startsWith('http://') || rawImage.startsWith('https://')) {
      _imageMode = 'url';
      _customUrlController = TextEditingController(text: rawImage);
      _selectedPresetAsset = 'assets/Tyrannosaurus_Rex.jpg';
    } else {
      _imageMode = 'preset';
      _customUrlController = TextEditingController();
      _selectedPresetAsset = rawImage.isNotEmpty && rawImage.startsWith('assets/')
          ? rawImage
          : DinoImages.getAssetPath(s.name, diet: s.diet);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _eraController.dispose();
    _discoveredInController.dispose();
    _lengthController.dispose();
    _weightController.dispose();
    _descController.dispose();
    _customUrlController.dispose();
    super.dispose();
  }

  // Dialog Izin Akses Galeri
  Future<bool> _showGalleryPermissionDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.photo_library,
                color: AppColors.natGeoGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Izin Akses Galeri',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        content: const Text(
          'Jurassica memerlukan izin untuk membuka penyimpanan foto perangkat Anda agar dapat memperbarui ilustrasi fosil spesimen ini.',
          style: TextStyle(
            fontSize: 13,
            height: 1.45,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'BATAL',
              style: TextStyle(
                color: AppColors.textMuted,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.natGeoGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'IZINKAN AKSES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _pickImageFromGallery() async {
    final bool granted = await _showGalleryPermissionDialog();
    if (!granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.textDark,
            content: Text('Akses galeri dibatalkan oleh pengguna.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      return;
    }

    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final base64String = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        setState(() {
          _galleryBase64Image = base64String;
          _imageMode = 'gallery';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Text('Gagal memilih gambar dari galeri: $e'),
          ),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      String finalImageSource = _selectedPresetAsset;
      final String inputUrl = _customUrlController.text.trim();

      if (_imageMode == 'gallery' && _galleryBase64Image != null) {
        finalImageSource = _galleryBase64Image!;
      } else if (inputUrl.isNotEmpty && (inputUrl.startsWith('http://') || inputUrl.startsWith('https://'))) {
        finalImageSource = inputUrl;
      } else if (_imageMode == 'url' && inputUrl.isNotEmpty) {
        finalImageSource = inputUrl;
      } else if (_imageMode == 'preset') {
        finalImageSource = _selectedPresetAsset;
      }

      final updatedSpecimen = widget.specimen.copyWith(
        name: _nameController.text.trim(),
        era: _eraController.text.trim().isEmpty
            ? 'Mesozoic Era'
            : _eraController.text.trim(),
        diet: _selectedDiet,
        discoveredIn: _discoveredInController.text.trim().isEmpty
            ? 'Asia / Amerika'
            : _discoveredInController.text.trim(),
        length: _lengthController.text.trim().isEmpty
            ? '6 - 9 Meter'
            : _lengthController.text.trim(),
        weight: _weightController.text.trim().isEmpty
            ? '2 - 4 Ton'
            : _weightController.text.trim(),
        description: _descController.text.trim(),
        imageUrl: finalImageSource,
      );

      await context.read<DinoCatalogProvider>().updateSpecimen(updatedSpecimen);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.natGeoGreen,
            content: Text(
              'Perubahan arsip "${_nameController.text}" berhasil diperbarui!',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Text('Gagal memperbarui data: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String inputUrl = _customUrlController.text.trim();
    String currentPreviewSource = _selectedPresetAsset;

    if (_imageMode == 'gallery' && _galleryBase64Image != null) {
      currentPreviewSource = _galleryBase64Image!;
    } else if (inputUrl.isNotEmpty && (inputUrl.startsWith('http://') || inputUrl.startsWith('https://'))) {
      currentPreviewSource = inputUrl;
    } else if (_imageMode == 'url' && inputUrl.isNotEmpty) {
      currentPreviewSource = inputUrl;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('EDIT ARSIP SPESIMEN'),
        actions: [
          IconButton(
            tooltip: 'Simpan Perubahan',
            icon: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.check_circle, color: AppColors.primaryYellow),
            onPressed: _isSubmitting ? null : _saveChanges,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('IDENTITAS TAKSONOMI'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration(
                    label: 'Nama Spesimen / Dinosaurus *',
                    hint: 'Contoh: Giganotosaurus Carolinii',
                    icon: Icons.pets,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama dinosaurus wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),

                _buildSectionTitle('SUMBER GAMBAR ILUSTRASI'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildChoiceChip('Galeri Foto', 'gallery', Icons.photo_camera_back_outlined),
                            const SizedBox(width: 8),
                            _buildChoiceChip('Preset Koleksi', 'preset', Icons.photo_library_outlined),
                            const SizedBox(width: 8),
                            _buildChoiceChip('URL Web', 'url', Icons.link_outlined),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      if (_imageMode == 'gallery') ...[
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.natGeoGreen,
                            side: const BorderSide(
                              color: AppColors.natGeoGreen,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          icon: const Icon(Icons.upload_file),
                          label: Text(
                            _galleryBase64Image == null
                                ? 'Pilih Gambar dari Galeri'
                                : 'Ganti Gambar Galeri',
                          ),
                          onPressed: _pickImageFromGallery,
                        ),
                      ] else if (_imageMode == 'preset') ...[
                        DropdownButtonFormField<String>(
                          initialValue: _selectedPresetAsset,
                          decoration: _inputDecoration(
                            label: 'Pilih Preset Anatomi',
                            icon: Icons.photo_library,
                          ),
                          items: DinoImages.presetOptions.entries.map((e) {
                            return DropdownMenuItem(
                              value: e.value,
                              child: Text(e.key, style: const TextStyle(fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedPresetAsset = val);
                            }
                          },
                        ),
                      ] else ...[
                        TextFormField(
                          controller: _customUrlController,
                          decoration: _inputDecoration(
                            label: 'URL Gambar Online (https://...)',
                            hint: 'Tempel link direct file gambar (.jpg / .png)',
                            icon: Icons.link,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ],

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 80,
                              height: 60,
                              child: DinoImages.buildImage(
                                imageSource: currentPreviewSource,
                                dinoName: _nameController.text,
                                diet: _selectedDiet,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Pratinjau foto spesimen yang akan tersimpan di katalog.',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _buildSectionTitle('EKOLOGI & ERA GEOLOGIS'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _selectedDiet,
                        decoration: _inputDecoration(
                          label: 'Kategori Diet',
                          icon: Icons.restaurant,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Carnivora', child: Text('Carnivora')),
                          DropdownMenuItem(value: 'Herbivora', child: Text('Herbivora')),
                          DropdownMenuItem(value: 'Omnivora', child: Text('Omnivora')),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedDiet = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _eraController,
                        decoration: _inputDecoration(
                          label: 'Era Geologis',
                          hint: 'Late Cretaceous',
                          icon: Icons.history_toggle_off,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                _buildSectionTitle('DIMENSI SPESIMEN'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _lengthController,
                        decoration: _inputDecoration(
                          label: 'Panjang Fisik',
                          hint: '10 - 13 Meter',
                          icon: Icons.straighten,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        decoration: _inputDecoration(
                          label: 'Estimasi Bobot',
                          hint: '6 - 8 Ton',
                          icon: Icons.scale_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                _buildSectionTitle('FORMASI PENGGALIAN'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _discoveredInController,
                  decoration: _inputDecoration(
                    label: 'Lokasi Penemuan Fosil',
                    hint: 'Misal: Patagonia, Argentina',
                    icon: Icons.terrain_outlined,
                  ),
                ),
                const SizedBox(height: 14),

                _buildSectionTitle('CATATAN PALEONTOLOGI & MORFOLOGI'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: _inputDecoration(
                    label: 'Deskripsi / Catatan Lapangan *',
                    hint: 'Tuliskan ciri unik spesimen ini...',
                    icon: Icons.description_outlined,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Deskripsi spesimen tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryYellow,
                      foregroundColor: AppColors.textDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.textDark,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.save_as_outlined),
                    label: Text(
                      _isSubmitting
                          ? 'MENYIMPAN PERUBAHAN...'
                          : 'SIMPAN PERUBAHAN ARSIP',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.6,
                      ),
                    ),
                    onPressed: _isSubmitting ? null : _saveChanges,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, String mode, IconData icon) {
    final bool isSelected = _imageMode == mode;
    return ChoiceChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : AppColors.textDark,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: isSelected ? Colors.white : AppColors.textDark,
            ),
          ),
        ],
      ),
      selectedColor: AppColors.natGeoGreen,
      backgroundColor: AppColors.surfaceElevated,
      onSelected: (_) => setState(() => _imageMode = mode),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        color: AppColors.natGeoGreen,
        letterSpacing: 0.8,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.natGeoGreen, width: 1.8),
      ),
    );
  }
}

typedef EditSpecimenDialog = EditSpecimenScreen;