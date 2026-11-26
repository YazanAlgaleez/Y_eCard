import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import 'app_surface_card.dart';

/// Input field for entering or pasting a game Player ID.
class PlayerIdInputCard extends StatelessWidget {
  final TextEditingController controller;

  const PlayerIdInputCard({
    super.key,
    required this.controller,
  });

  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final pastedText = clipboardData?.text;
    if (pastedText != null && pastedText.isNotEmpty) {
      controller.text = pastedText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'معرف اللاعب (Player ID)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        AppSurfaceCard(
          padding: EdgeInsets.symmetric(
            horizontal: layout.cardPadding,
            vertical: 2,
          ),
          borderRadius: AppDimensions.inputRadius,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'أدخل رقم المعرف هنا...',
                  ),
                ),
              ),
              IconButton(
                tooltip: 'لصق',
                icon: const Icon(Icons.content_paste_rounded, size: 19),
                onPressed: _pasteFromClipboard,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
