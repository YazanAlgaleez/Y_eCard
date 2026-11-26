import 'package:flutter/material.dart';

import '../utils/responsive_layout.dart';

/// Centers page content within [ResponsiveLayout.maxContentWidth] on large
/// displays and applies adaptive horizontal padding inside [SafeArea].
class ResponsivePageContainer extends StatelessWidget {
  final Widget child;

  const ResponsivePageContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: layout.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: layout.horizontalPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
