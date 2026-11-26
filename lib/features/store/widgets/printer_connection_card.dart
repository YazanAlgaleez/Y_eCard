import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../printer/cubit/printer_state.dart';
import 'app_surface_card.dart';

/// Displays Bluetooth thermal printer connection status and a toggle switch.
class PrinterConnectionCard extends StatelessWidget {
  final PrinterState printerState;
  final VoidCallback onToggleConnection;

  const PrinterConnectionCard({
    super.key,
    required this.printerState,
    required this.onToggleConnection,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = printerState.isConnected;
    final secondaryColor = Theme.of(context).textTheme.bodySmall?.color;
    final layout = ResponsiveLayout.of(context);

    return AppSurfaceCard(
      padding: EdgeInsets.all(layout.cardPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.print_rounded,
                  color: isConnected ? AppColors.emeraldMint : secondaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الطابعة الحرارية (بلوتوث)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        isConnected
                            ? 'متصل: ${printerState.printerName}'
                            : 'غير متصل (تعمل كـ مستخدم عادي)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isConnected ? AppColors.emeraldMint : secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: isConnected,
            onChanged: (_) => onToggleConnection(),
          ),
        ],
      ),
    );
  }
}
