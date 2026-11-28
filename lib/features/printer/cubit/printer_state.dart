import 'package:flutter/foundation.dart';

import '../models/printer_device_model.dart';

/// Lifecycle states for Bluetooth thermal printer discovery, connection, and printing.
enum PrinterStatus {
  idle,
  loadingDevices,
  connecting,
  connected,
  printing,
  printSuccess,
  error,
}

/// Immutable state for Bluetooth thermal printer discovery, connection, and jobs.
class PrinterState {
  final PrinterStatus status;
  final bool isConnected;
  final PrinterDeviceModel? connectedPrinter;
  final List<PrinterDeviceModel> pairedDevices;
  final String? errorMessage;
  final String? statusMessage;

  const PrinterState({
    this.status = PrinterStatus.idle,
    this.isConnected = false,
    this.connectedPrinter,
    this.pairedDevices = const <PrinterDeviceModel>[],
    this.errorMessage,
    this.statusMessage,
  });

  String? get printerName => connectedPrinter?.name;

  bool get isScanning => status == PrinterStatus.loadingDevices;
  bool get isConnecting => status == PrinterStatus.connecting;
  bool get isPrinting => status == PrinterStatus.printing;
  bool get isBusy => isScanning || isConnecting || isPrinting;

  PrinterState copyWith({
    PrinterStatus? status,
    bool? isConnected,
    PrinterDeviceModel? connectedPrinter,
    List<PrinterDeviceModel>? pairedDevices,
    String? errorMessage,
    String? statusMessage,
    bool clearConnectedPrinter = false,
    bool clearError = false,
    bool clearStatusMessage = false,
  }) {
    return PrinterState(
      status: status ?? this.status,
      isConnected: isConnected ?? this.isConnected,
      connectedPrinter: clearConnectedPrinter
          ? null
          : (connectedPrinter ?? this.connectedPrinter),
      pairedDevices: pairedDevices ?? this.pairedDevices,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      statusMessage:
          clearStatusMessage ? null : (statusMessage ?? this.statusMessage),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PrinterState &&
        other.status == status &&
        other.isConnected == isConnected &&
        other.connectedPrinter == connectedPrinter &&
        listEquals(other.pairedDevices, pairedDevices) &&
        other.errorMessage == errorMessage &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode => Object.hash(
        status,
        isConnected,
        connectedPrinter,
        Object.hashAll(pairedDevices),
        errorMessage,
        statusMessage,
      );
}
