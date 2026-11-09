import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';

class AddSpecimenDialog extends StatefulWidget {
  const AddSpecimenDialog({super.key});

  @override
  State<AddSpecimenDialog> createState() => _AddSpecimenDialogState();
}

class _AddSpecimenDialogState extends State<AddSpecimenDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _eraController = TextEditingController();
  final _lengthController = TextEditingController();
  final _weightController = TextEditingController();
  final _locationController = TextEditingController();
  final _descController = TextEditingController();

  String _selectedDiet = 'Carnivora';
  bool _isSubmitting = false;

  final List<String> _dietOptions = ['Carnivora', 'Herbivora', 'Omnivora'];

  @override
  void dispose() {
    _nameController.dispose();
    _eraController.dispose();
    _lengthController.dispose();
    _weightController.dispose();
    _locationController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submitSpecimen() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Generate ID unik sederhana berbasis timestamp
    final String newId = 'sp_${DateTime.now().millisecondsSinceEpoch}';

    final newSpecimen = DinoSpecimen(
      id: newId,
      name: _nameController.text.trim(),
      diet: _selectedDiet,
      era: _eraController.text.trim(),
      length: _lengthController.text.trim(),
      weight: _weightController.text.trim(),
      description: _descController.text.trim(),
      discoveredIn: _locationController.text.trim(),
      likeCount: 0,
    );

    try {
      final provider = Provider.of<DinoCatalogProvider>(context, listen: false);
      await provider.addSpecimen(newSpecimen);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.natGeoGreen,
            content: Text('Spesimen baru berhasil ditambahkan ke Supabase!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Gagal menambah spesimen: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ARSIP SPESIMEN BARU',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Spesimen *',
                    hintText: 'Misal: Carnotaurus Sastrei',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedDiet,
                  decoration: const InputDecoration(
                    labelText: 'Kategori Diet',
                    border: OutlineInputBorder(),
                  ),
                  items: _dietOptions.map((diet) {
                    return DropdownMenuItem(value: diet, child: Text(diet));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedDiet = val);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _eraController,
                  decoration: const InputDecoration(
                    labelText: 'Periode Era Geologis *',
                    hintText: 'Misal: Late Cretaceous (72 - 69 Mya)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _lengthController,
                        decoration: const InputDecoration(
                          labelText: 'Panjang *',
                          hintText: '7.5 - 9.0 meter',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Wajib diisi'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          labelText: 'Estimasi Berat *',
                          hintText: '1.3 - 2.1 ton',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Wajib diisi'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Lokasi Penemuan Fosil *',
                    hintText: 'Misal: Formasi La Colonia, Argentina',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Anatomi & Karakteristik *',
                    hintText: 'Theropoda bertanduk dengan mata kecil...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryYellow,
                      foregroundColor: AppColors.textDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _isSubmitting ? null : _submitSpecimen,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.textDark,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'ARSIPKAN KE SUPABASE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}