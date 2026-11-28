import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../printer/cubit/printer_state.dart';
import '../../printer/models/printer_device_model.dart';
import 'app_surface_card.dart';

/// Displays Bluetooth thermal printer status, paired devices, and connection actions.
class PrinterConnectionCard extends StatelessWidget {
  final PrinterState printerState;
  final VoidCallback onLoadDevices;
  final ValueChanged<PrinterDeviceModel> onConnectDevice;
  final VoidCallback onDisconnect;

  const PrinterConnectionCard({
    super.key,
    required this.printerState,
    required this.onLoadDevices,
    required this.onConnectDevice,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = printerState.isConnected;
    final secondaryColor = Theme.of(context).textTheme.bodySmall?.color;
    final layout = ResponsiveLayout.of(context);

    return AppSurfaceCard(
      padding: EdgeInsets.all(layout.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                          ? 'متصل: ${printerState.printerName ?? 'طابعة بلوتوث'}'
                          : 'غير متصل',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isConnected
                            ? AppColors.emeraldMint
                            : secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isConnected)
                TextButton(
                  onPressed: printerState.isBusy ? null : onDisconnect,
                  child: const Text('فصل'),
                )
              else
                OutlinedButton.icon(
                  onPressed: printerState.isBusy ? null : onLoadDevices,
                  icon: printerState.isScanning
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.bluetooth_searching_rounded, size: 18),
                  label: Text(
                    printerState.isScanning ? 'جاري البحث...' : 'بحث',
                  ),
                ),
            ],
          ),
          if (printerState.errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              printerState.errorMessage!,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ] else if (printerState.statusMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              printerState.statusMessage!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.emeraldMint,
              ),
            ),
          ],
          if (printerState.pairedDevices.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 8),
            Text(
              'الطابعات المقترنة:',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            ...printerState.pairedDevices.map((device) {
              final isCurrentDevice =
                  printerState.connectedPrinter?.macAddress == device.macAddress;
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  isCurrentDevice
                      ? Icons.check_circle_rounded
                      : Icons.print_outlined,
                  color: isCurrentDevice ? AppColors.emeraldMint : secondaryColor,
                ),
                title: Text(
                  device.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  device.macAddress,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: ElevatedButton(
                  onPressed: printerState.isBusy || isCurrentDevice
                      ? null
                      : () => onConnectDevice(device),
                  child: Text(
                    isCurrentDevice
                        ? 'متصل'
                        : printerState.isConnecting
                            ? 'جاري الربط...'
                            : 'اتصال',
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}