import 'package:flutter_bloc/flutter_bloc.dart';

import 'printer_state.dart';

/// Controls thermal printer connection state for receipts and order history.
class PrinterCubit extends Cubit<PrinterState> {
  static const String defaultPrinterName = 'POS-58mm Bluetooth';

  PrinterCubit() : super(const PrinterState(isConnected: false));

  void connectPrinter(String printerName) {
    emit(PrinterState(isConnected: true, printerName: printerName));
  }

  void disconnectPrinter() {
    emit(const PrinterState(isConnected: false, printerName: null));
  }

  void toggleConnection() {
    if (state.isConnected) {
      disconnectPrinter();
    } else {
      connectPrinter(defaultPrinterName);
    }
  }
}
