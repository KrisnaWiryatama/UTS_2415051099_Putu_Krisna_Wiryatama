import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class StateFeedbackWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  const StateFeedbackWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.iconColor,
  });

  factory StateFeedbackWidget.empty({
    required String message,
    VoidCallback? onReset,
  }) {
    return StateFeedbackWidget(
      icon: Icons.search_off_rounded,
      title: 'Tidak Ada Spesimen Ditemukan',
      message: message,
      actionLabel: onReset != null ? 'Reset Filter' : null,
      onAction: onReset,
      iconColor: AppColors.textMuted,
    );
  }

  factory StateFeedbackWidget.error({
    required String message,
    required VoidCallback onRetry,
  }) {
    return StateFeedbackWidget(
      icon: Icons.wifi_off_rounded,
      title: 'Koneksi Terputus / Galat Server',
      message: message,
      actionLabel: 'Coba Lagi',
      onAction: onRetry,
      iconColor: Colors.orange.shade800,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.textMuted).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: iconColor ?? AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
                height: 1.4,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 18),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.natGeoGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: onAction,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(
                  actionLabel!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}