import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:y_ecard/features/printer/services/esc_pos_receipt_rasterizer.dart';

import '../models/printer_device_model.dart';
import '../models/receipt_print_data.dart';


/// Exception thrown by [BluetoothPrinterService] with a user-facing Arabic message.
class PrinterServiceException implements Exception {
  final String message;

  const PrinterServiceException(this.message);

  @override
  String toString() => message;
}

/// Manages Bluetooth permissions, paired device discovery, printer connection,
/// and line-by-line ESC/POS receipt printing via `print_bluetooth_thermal`.
class BluetoothPrinterService {
  final EscPosLineFormatter _lineFormatter;

  const BluetoothPrinterService({
    EscPosLineFormatter lineFormatter = const EscPosLineFormatter(),
  }) : _lineFormatter = lineFormatter;

  Future<void> ensureReady() async {
    if (kIsWeb) {
      throw const PrinterServiceException(
        'طباعة البلوتوث الحرارية غير مدعومة على الويب.',
      );
    }

    if (Platform.isAndroid) {
      final statuses = await <Permission>[
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();

      final scanStatus = statuses[Permission.bluetoothScan];
      final connectStatus = statuses[Permission.bluetoothConnect];

      if (scanStatus?.isPermanentlyDenied == true ||
          connectStatus?.isPermanentlyDenied == true) {
        throw const PrinterServiceException(
          'تم رفض صلاحيات البلوتوث بشكل دائم. يرجى تفعيلها من إعدادات التطبيق.',
        );
      }

      var hasPluginPermission =
          await PrintBluetoothThermal.isPermissionBluetoothGranted;

      if (!hasPluginPermission) {
        final locationStatus = await Permission.locationWhenInUse.request();
        if (locationStatus.isPermanentlyDenied) {
          throw const PrinterServiceException(
            'يرجى تفعيل صلاحية الموقع والبلوتوث من إعدادات التطبيق.',
          );
        }
        hasPluginPermission =
            await PrintBluetoothThermal.isPermissionBluetoothGranted;
      }

      if (!hasPluginPermission &&
          (scanStatus?.isGranted != true ||
              connectStatus?.isGranted != true)) {
        throw const PrinterServiceException(
          'يرجى منح صلاحيات البلوتوث للبحث عن الطابعات والاتصال بها.',
        );
      }
    }

    final isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
    if (!isBluetoothEnabled) {
      throw const PrinterServiceException(
        'البلوتوث متوقف حالياً. يرجى تشغيل البلوتوث والمحاولة مرة أخرى.',
      );
    }
  }

  Future<List<PrinterDeviceModel>> getPairedDevices() async {
    await ensureReady();

    final devices = await PrintBluetoothThermal.pairedBluetooths;
    return devices
        .where((device) => device.macAdress.trim().isNotEmpty)
        .map(
          (device) => PrinterDeviceModel(
            name: device.name.trim().isEmpty
                ? 'طابعة بلوتوث'
                : device.name.trim(),
            macAddress: device.macAdress.trim(),
          ),
        )
        .toList(growable: false);
  }

  Future<bool> isConnected() async {
    if (kIsWeb) return false;
    return PrintBluetoothThermal.connectionStatus;
  }

  Future<void> connect(PrinterDeviceModel device) async {
    await ensureReady();

    final alreadyConnected = await PrintBluetoothThermal.connectionStatus;
    if (alreadyConnected) {
      await PrintBluetoothThermal.disconnect;
    }

    final connected = await PrintBluetoothThermal.connect(
      macPrinterAddress: device.macAddress,
    );
    if (!connected) {
      throw PrinterServiceException(
        'تعذر الاتصال بالطابعة "${device.name}". تأكد من تشغيلها وقربها من الهاتف.',
      );
    }
  }

  Future<void> disconnect() async {
    if (kIsWeb) return;
    await PrintBluetoothThermal.disconnect;
  }

  /// Sends receipt line-by-line so portable thermal printers don't stall or power off.
  Future<void> printReceipt(ReceiptPrintData receipt) async {
    await ensureReady();

    final connected = await PrintBluetoothThermal.connectionStatus;
    if (!connected) {
      throw const PrinterServiceException(
        'الطابعة غير متصلة. يرجى اختيار الطابعة والاتصال بها أولاً.',
      );
    }

    final linePayloads = _lineFormatter.buildLinePayloads(receipt);
    for (var i = 0; i < linePayloads.length; i++) {
      final written = await PrintBluetoothThermal.writeBytes(linePayloads[i]);
      if (!written) {
        throw const PrinterServiceException(
          'فشل إرسال سطر الطباعة إلى الطابعة الحرارية.',
        );
      }
      if (i < linePayloads.length - 1) {
        await Future<void>.delayed(const Duration(milliseconds: 45));
      }
    }
  }
}