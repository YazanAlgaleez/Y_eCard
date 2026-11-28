import 'dart:convert';

import '../models/receipt_print_data.dart';

/// Builds a short, compact receipt layout tailored for 58mm portable printers.
class EscPosLineFormatter {
  const EscPosLineFormatter();

  /// Returns compact line payloads (each ending with LF `0x0A`).
  List<List<int>> buildLinePayloads(ReceiptPrintData receipt) {
    final payloads = <List<int>>[];

    // ESC @: Initialize printer
    // ESC 3 14: Compact vertical line spacing (14 dots)
    // ESC t 22: Codepage setup
    payloads.add(const <int>[0x1B, 0x40, 0x18, 0x7, 0x0B, 0x1B, 0x74, 0x16]);

    // Centered header + title
    payloads.add(const <int>[0x1B, 0x61, 0x01]);
    payloads.add(_composeLine(receipt.storeName, bold: true));
    payloads.add(_composeLine('${receipt.operationType} - ${receipt.itemTitle}'));
    payloads.add(_composeLine('------------------'));

    // Left-aligned compact rows
    payloads.add(const <int>[0x1B, 0x61, 0x00]);
    payloads.add(_composeLine('Ord: ${receipt.orderNumber}  Qty: ${receipt.quantity}'));
    payloads.add(_composeLine(
      'Total: ${receipt.totalPrice.toStringAsFixed(2)} ${receipt.currencyLabel}',
      bold: true,
    ));
    if (receipt.remainingBalance != null) {
      payloads.add(_composeLine(
        'Bal: ${receipt.remainingBalance!.toStringAsFixed(2)} ${receipt.currencyLabel}',
      ));
    }

    // Centered pin/reference + date/footer
    payloads.add(const <int>[0x1B, 0x61, 0x01]);
    payloads.add(_composeLine('------------------'));
    payloads.add(_composeLine('${receipt.referenceLabel}: [${receipt.referenceValue}]', bold: true));
    payloads.add(_composeLine('${receipt.timestamp}  |  Thank you'));
    payloads.add(_composeLine('${receipt.divby}',bold: true));

    return payloads;
  }

  List<int> _composeLine(
    String text, {
    bool bold = false,
  }) {
    final cleaned = _sanitizeLine(text);
    return <int>[
      0x1B, 0x45, bold ? 0x01 : 0x00, // ESC E: Bold
      ...latin1.encode(cleaned),
      0x0A, // LF
      0x1B, 0x45, 0x00, // Reset bold
    ];
  }

  String _sanitizeLine(String input) {
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      if (rune >= 0x20 && rune <= 0x7E) {
        buffer.writeCharCode(rune);
      } else if (rune == 0x0A || rune == 0x0D || rune == 0x09) {
        buffer.write(' ');
      }
    }
    return buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}