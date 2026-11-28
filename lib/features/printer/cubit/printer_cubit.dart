import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/printer_device_model.dart';
import '../models/receipt_print_data.dart';
import '../services/bluetooth_printer_service.dart';
import 'printer_state.dart';

/// Coordinates Bluetooth permissions, paired printer selection, connection,
/// and ESC/POS receipt printing without blocking the UI.
class PrinterCubit extends Cubit<PrinterState> {
  final BluetoothPrinterService _printerService;

  PrinterCubit({BluetoothPrinterService? printerService})
      : _printerService = printerService ?? const BluetoothPrinterService(),
        super(const PrinterState());

  Future<void> loadPairedPrinters() async {
    emit(
      state.copyWith(
        status: PrinterStatus.loadingDevices,
        clearError: true,
        clearStatusMessage: true,
      ),
    );

    try {
      final devices = await _printerService.getPairedDevices();
      if (isClosed) return;
      emit(
        state.copyWith(
          status:
              state.isConnected ? PrinterStatus.connected : PrinterStatus.idle,
          pairedDevices: devices,
          clearError: true,
        ),
      );
    } on PrinterServiceException catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          errorMessage: 'حدث خطأ غير متوقع أثناء البحث عن الطابعات المقترنة.',
        ),
      );
    }
  }

  Future<void> connectToPrinter(PrinterDeviceModel device) async {
    emit(
      state.copyWith(
        status: PrinterStatus.connecting,
        clearError: true,
        clearStatusMessage: true,
      ),
    );

    try {
      await _printerService.connect(device);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.connected,
          isConnected: true,
          connectedPrinter: device,
          statusMessage: 'تم الاتصال بالطابعة: ${device.name}',
          clearError: true,
        ),
      );
    } on PrinterServiceException catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          isConnected: false,
          clearConnectedPrinter: true,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          isConnected: false,
          clearConnectedPrinter: true,
          errorMessage: 'تعذر الاتصال بالطابعة المحددة.',
        ),
      );
    }
  }

  Future<void> disconnectPrinter() async {
    try {
      await _printerService.disconnect();
    } catch (_) {
      // Ensure local UI state resets cleanly even if socket already closed.
    }
    if (isClosed) return;
    emit(
      state.copyWith(
        status: PrinterStatus.idle,
        isConnected: false,
        clearConnectedPrinter: true,
        clearError: true,
        statusMessage: 'تم فصل الطابعة.',
      ),
    );
  }

  Future<void> printReceipt(ReceiptPrintData receipt) async {
    if (!state.isConnected || state.connectedPrinter == null) {
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          errorMessage: 'يرجى اختيار طابعة بلوتوث والاتصال بها أولاً.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: PrinterStatus.printing,
        clearError: true,
        clearStatusMessage: true,
      ),
    );

    try {
      await _printerService.printReceipt(receipt);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.printSuccess,
          statusMessage: 'تمت طباعة الإيصال بنجاح!',
          clearError: true,
        ),
      );
    } on PrinterServiceException catch (error) {
      final stillConnected = await _printerService.isConnected();
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          isConnected: stillConnected,
          clearConnectedPrinter: !stillConnected,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: PrinterStatus.error,
          errorMessage: 'حدث خطأ أثناء إرسال الإيصال إلى الطابعة.',
        ),
      );
    }
  }

  void clearFeedback() {
    emit(
      state.copyWith(
        status:
            state.isConnected ? PrinterStatus.connected : PrinterStatus.idle,
        clearError: true,
        clearStatusMessage: true,
      ),
    );
  }
}
