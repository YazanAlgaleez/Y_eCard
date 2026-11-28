import 'package:flutter/material.dart';

import '../theme/app_styles.dart';

/// Lightweight [MediaQuery]-based helper providing both adaptive breakpoints
/// and clamped fluid sizing across phones, compact screens, and tablets.
class ResponsiveLayout {
  static const double _baselineWidth = 390.0;
  static const double _baselineHeight = 844.0;

  final Size screenSize;
  final TextScaler textScaler;

  const ResponsiveLayout._(this.screenSize, this.textScaler);

  factory ResponsiveLayout.of(BuildContext context) {
    return ResponsiveLayout._(
      MediaQuery.sizeOf(context),
      MediaQuery.textScalerOf(context),
    );
  }

  bool get isCompactWidth => screenSize.width < 360;
  bool get isUltraCompactWidth => screenSize.width < 310;
  bool get isTabletWidth => screenSize.width >= 600;
  bool get isWideWidth => screenSize.width >= 900;
  bool get isCompactHeight => screenSize.height < 680;
  bool get isLandscape => screenSize.width > screenSize.height;

  double get widthScale =>
      (screenSize.width / _baselineWidth).clamp(0.85, 1.35);

  double get heightScale =>
      (screenSize.height / _baselineHeight).clamp(0.82, 1.25);

  double get clampedTextScale => textScaler.scale(1.0).clamp(0.9, 1.25);

  double scaleWidth(
    double base, {
    double minFactor = 0.85,
    double maxFactor = 1.35,
  }) {
    final factor = (screenSize.width / _baselineWidth).clamp(
      minFactor,
      maxFactor,
    );
    return (base * factor).roundToDouble();
  }

  double scaleHeight(
    double base, {
    double minFactor = 0.82,
    double maxFactor = 1.25,
  }) {
    final factor = (screenSize.height / _baselineHeight).clamp(
      minFactor,
      maxFactor,
    );
    return (base * factor).roundToDouble();
  }

  double scaledFontSize(
    double base, {
    double minFactor = 0.92,
    double maxFactor = 1.15,
  }) {
    final factor = (screenSize.width / _baselineWidth).clamp(
      minFactor,
      maxFactor,
    );
    return (base * factor).roundToDouble();
  }

  double scaledIconSize(
    double base, {
    double minFactor = 0.85,
    double maxFactor = 1.2,
  }) {
    final factor = (screenSize.width / _baselineWidth).clamp(
      minFactor,
      maxFactor,
    );
    return (base * factor).roundToDouble();
  }

  double get maxContentWidth {
    if (isWideWidth) return 920.0;
    if (isTabletWidth) return 680.0;
    return double.infinity;
  }

  double? get floatingSnackBarWidth => isTabletWidth ? 460.0 : null;

  double get horizontalPadding => scaleWidth(
        AppDimensions.screenHorizontalPadding,
        minFactor: 0.75,
        maxFactor: 1.5,
      );

  double get sectionSpacing => scaleHeight(AppDimensions.sectionSpacing);

  double get itemSpacing => scaleHeight(AppDimensions.itemSpacing);

  double get smallSpacing => scaleWidth(
        AppDimensions.smallSpacing,
        minFactor: 0.75,
        maxFactor: 1.25,
      );

  double get cardPadding => scaleWidth(
        AppDimensions.cardPadding,
        minFactor: 0.82,
        maxFactor: 1.25,
      );

  double get listBottomPadding => scaleHeight(20.0);

  double get filterBarHeight => (40.0 * clampedTextScale).clamp(38.0, 48.0);

  double get headerButtonSize =>
      scaleWidth(40.0, minFactor: 0.9, maxFactor: 1.15);

  double get minTouchTarget => 44.0;

  int get productGridColumns {
    if (isWideWidth) return 4;
    if (isTabletWidth || (isLandscape && screenSize.width >= 540)) return 3;
    return 2;
  }

  double get productCardAspectRatio {
    final baseRatio = isTabletWidth
        ? 1.04
        : (isCompactWidth ? 0.86 : 0.95);
    return (baseRatio / clampedTextScale.clamp(1.0, 1.2)).clamp(0.74, 1.12);
  }

  int get packageGridColumns {
    if (isWideWidth) return 4;
    if (isTabletWidth) return 3;
    return 2;
  }

  double get packageCardAspectRatio {
    final baseRatio = isCompactWidth ? 1.45 : 1.65;
    return (baseRatio / clampedTextScale.clamp(1.0, 1.2)).clamp(1.2, 1.75);
  }

  double get productIconBoxSize =>
      scaleWidth(54.0, minFactor: 0.82, maxFactor: 1.15);

  double get productIconSize =>
      scaledIconSize(30.0, minFactor: 0.82, maxFactor: 1.15);

  double get quantityPillWidth =>
      scaleWidth(44.0, minFactor: 0.9, maxFactor: 1.2);

  double get quantityPillHeight => (40.0 * clampedTextScale).clamp(38.0, 48.0);

  double get receiptQrSize =>
      scaleHeight(68.0, minFactor: 0.76, maxFactor: 1.15);
}
