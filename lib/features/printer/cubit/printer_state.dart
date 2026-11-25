/// Immutable connection state for the Bluetooth thermal receipt printer.
class PrinterState {
  final bool isConnected;
  final String? printerName;

  const PrinterState({
    required this.isConnected,
    this.printerName,
  });

  PrinterState copyWith({
    bool? isConnected,
    String? printerName,
  }) {
    return PrinterState(
      isConnected: isConnected ?? this.isConnected,
      printerName: printerName ?? this.printerName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PrinterState &&
        other.isConnected == isConnected &&
        other.printerName == printerName;
  }

  @override
  int get hashCode => Object.hash(isConnected, printerName);
}
