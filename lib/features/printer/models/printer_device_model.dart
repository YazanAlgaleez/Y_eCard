/// Represents a paired Bluetooth printer device discovered on the host device.
class PrinterDeviceModel {
  final String name;
  final String macAddress;

  const PrinterDeviceModel({
    required this.name,
    required this.macAddress,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PrinterDeviceModel &&
        other.name == name &&
        other.macAddress == macAddress;
  }

  @override
  int get hashCode => Object.hash(name, macAddress);
}
