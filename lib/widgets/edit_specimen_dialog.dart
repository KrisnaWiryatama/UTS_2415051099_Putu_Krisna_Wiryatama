import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';
import '../providers/dino_catalog_provider.dart';

class EditSpecimenDialog extends StatefulWidget {
  final DinoSpecimen specimen;

  const EditSpecimenDialog({super.key, required this.specimen});

  @override
  State<EditSpecimenDialog> createState() => _EditSpecimenDialogState();
}

class _EditSpecimenDialogState extends State<EditSpecimenDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _eraController;
  late TextEditingController _lengthController;
  late TextEditingController _weightController;
  late TextEditingController _locationController;
  late TextEditingController _descController;
  late String _selectedDiet;

  bool _isSubmitting = false;
  final List<String> _dietOptions = ['Carnivora', 'Herbivora', 'Omnivora'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.specimen.name);
    _eraController = TextEditingController(text: widget.specimen.era);
    _lengthController = TextEditingController(text: widget.specimen.length);
    _weightController = TextEditingController(text: widget.specimen.weight);
    _locationController =
        TextEditingController(text: widget.specimen.discoveredIn);
    _descController = TextEditingController(text: widget.specimen.description);

    _selectedDiet = _dietOptions.contains(widget.specimen.diet)
        ? widget.specimen.diet
        : 'Carnivora';
  }

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

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final updated = DinoSpecimen(
      id: widget.specimen.id,
      name: _nameController.text.trim(),
      diet: _selectedDiet,
      era: _eraController.text.trim(),
      length: _lengthController.text.trim(),
      weight: _weightController.text.trim(),
      description: _descController.text.trim(),
      discoveredIn: _locationController.text.trim(),
      likeCount: widget.specimen.likeCount,
    );

    try {
      await Provider.of<DinoCatalogProvider>(context, listen: false)
          .updateSpecimen(updated);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.natGeoGreen,
            content: Text('Data spesimen Anda berhasil diperbarui di Supabase!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Gagal memperbarui spesimen: $e'),
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
                      'EDIT SPESIMEN SAYA',
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
                    onPressed: _isSubmitting ? null : _submitUpdate,
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
                            'SIMPAN PERUBAHAN',
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