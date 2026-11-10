import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/dino_specimen.dart';

class ReportFeedbackDialog extends StatefulWidget {
  final DinoSpecimen specimen;
  final String type; // 'report' atau 'feedback'

  const ReportFeedbackDialog({
    super.key,
    required this.specimen,
    required this.type,
  });

  @override
  State<ReportFeedbackDialog> createState() => _ReportFeedbackDialogState();
}

class _ReportFeedbackDialogState extends State<ReportFeedbackDialog> {
  final _messageController = TextEditingController();
  String _selectedCategory = 'Koreksi Data Taksonomi';

  List<String> get _categories => widget.type == 'report'
      ? [
          'Koreksi Data Taksonomi',
          'Kesalahan Periode Era / Ukuran',
          'Lokasi Fosil Tidak Akurat',
          'Duplikasi Spesimen',
        ]
      : [
          'Tambahan Fakta Baru',
          'Saran Referensi Jurnal',
          'Apresiasi Deskripsi',
          'Lainnya',
        ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.first;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReport = widget.type == 'report';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isReport
                          ? Icons.flag_outlined
                          : Icons.rate_review_outlined,
                      color: isReport
                          ? Colors.orange.shade800
                          : AppColors.natGeoGreen,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isReport ? 'LAPORKAN SPESIMEN' : 'BERI FEEDBACK',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Spesimen: ${widget.specimen.name}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat, style: const TextStyle(fontSize: 13)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _messageController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: isReport ? 'Detail Laporan' : 'Masukan Anda',
                hintText: isReport
                    ? 'Jelaskan data yang kurang tepat...'
                    : 'Tuliskan catatan tambahan...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isReport ? Colors.orange.shade800 : AppColors.natGeoGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.natGeoGreen,
                      content: Text(
                        isReport
                            ? 'Laporan untuk ${widget.specimen.name} telah dikirim ke tim kurator.'
                            : 'Terima kasih atas masukan Anda untuk ${widget.specimen.name}!',
                      ),
                    ),
                  );
                },
                child: Text(
                  isReport ? 'KIRIM LAPORAN' : 'KIRIM MASUKAN',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}