import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/merchant_level_model.dart';
import '../models/package_option_model.dart';
import '../models/product_model.dart';
import '../models/store_transaction_model.dart';

/// Static sample catalog, wallet, and transaction data for the store UI.
abstract final class MockStoreData {
  static const double walletBalance = 145.50;
  static const String currencyLabel = 'د.أ';
  static const int currentMerchantLevelNumber = 2;
  static const String merchantTierLabel = 'جملة - مستوى 2';
  static const String nextMerchantTierLabel = 'وكيل معتمد - مستوى 3';
  static const double merchantTierProgress = 0.65;
  static const double currentMonthlySales = 1300.0;
  static const double nextLevelTargetSales = 2000.0;

  static const List<MerchantLevelModel> merchantLevels = [
    MerchantLevelModel(
      levelNumber: 1,
      title: 'تاجر مبتدئ - مستوى 1',
      discountLabel: 'خصم أساسي',
      monthlyTargetLabel: '0 - 500 د.أ شهرياً',
      icon: Icons.storefront_rounded,
      accentColor: AppColors.accentBlue,
      benefits: [
        'أسعار التجزئة المخفضة لجميع الألعاب والبطاقات',
        'إصدار فوري للأكواد الرقمية والشحن المباشر',
        'دعم فني عبر المحادثة المباشرة',
      ],
    ),
    MerchantLevelModel(
      levelNumber: 2,
      title: 'جملة - مستوى 2',
      discountLabel: 'خصم 3% إضافي',
      monthlyTargetLabel: '500 - 2,000 د.أ شهرياً',
      icon: Icons.workspace_premium_rounded,
      accentColor: AppColors.primaryViolet,
      benefits: [
        'خصم جملة إضافي 3% على جميع فئات الشحن',
        'دعم طباعة الإيصالات الحرارية عبر البلوتوث',
        'أولوية في معالجة طلبات الشحن المباشر ID',
      ],
    ),
    MerchantLevelModel(
      levelNumber: 3,
      title: 'وكيل معتمد - مستوى 3',
      discountLabel: 'خصم 5% إضافي',
      monthlyTargetLabel: '2,000 - 5,000 د.أ شهرياً',
      icon: Icons.verified_rounded,
      accentColor: AppColors.emeraldMint,
      benefits: [
        'خصم 5% وأسعار خاصة لبطاقات الألعاب العالمية',
        'شحن رصيد مرن عبر التحويل البنكي والمحافظ',
        'إمكانية طلب كميات كبيرة بضغطة واحدة',
      ],
    ),
    MerchantLevelModel(
      levelNumber: 4,
      title: 'شريك استراتيجي - مستوى 4',
      discountLabel: 'خصم 8% VIP',
      monthlyTargetLabel: 'أكثر من 5,000 د.أ شهرياً',
      icon: Icons.diamond_rounded,
      accentColor: AppColors.accentAmber,
      benefits: [
        'أعلى هامش ربح وخصم VIP يصل إلى 8%',
        'مدير حساب مخصص ودعم فني على مدار الساعة',
        'ربط مباشر عبر API وتقارير مبيعات متقدمة',
      ],
    ),
  ];

  static const String allCategory = 'الكل';
  static const String directIdCategory = 'شحن ID';
  static const String codesCategory = 'أكواد';

  static const String sampleOrderNumber = '#ORD-9482';
  static const String sampleOrderTimestamp = '24-11-2026 09:16';
  static const String fallbackPlayerId = '5192847361';
  static const String sampleVoucherCode = 'GZX9-4821-PLKM';

  static const List<String> categories = [
    allCategory,
    'ألعاب',
    'بطاقات رقمية',
    directIdCategory,
    codesCategory,
  ];

  static const List<int> quantityOptions = [1, 2, 3, 5];

  static const List<ProductModel> products = [
    ProductModel(
      title: 'ببجي موبايل',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.sports_esports_rounded,
      accentColor: AppColors.accentAmber,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
    ProductModel(
      title: 'فري فاير',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.local_fire_department_rounded,
      accentColor: AppColors.accentRed,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'جوجل بلاي',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.play_arrow_rounded,
      accentColor: AppColors.emeraldMint,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE', 'سعودي SA'],
    ),
    ProductModel(
      title: 'بلايستيشن',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.gamepad_rounded,
      accentColor: AppColors.accentBlue,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE'],
    ),
    ProductModel(
      title: 'جواكر',
      badge: 'شحن ID',
      category: 'شحن ID',
      icon: Icons.style_rounded,
      accentColor: AppColors.accentPurple,
      supportsDirectId: true,
      supportsVoucherCode: false,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'نتفليكس',
      badge: 'كود فوري',
      category: 'أكواد',
      icon: Icons.movie_filter_rounded,
      accentColor: AppColors.accentRose,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
    ProductModel(
      title: 'ببجي موبايل',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.sports_esports_rounded,
      accentColor: AppColors.accentAmber,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
    ProductModel(
      title: 'فري فاير',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.local_fire_department_rounded,
      accentColor: AppColors.accentRed,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'جوجل بلاي',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.play_arrow_rounded,
      accentColor: AppColors.emeraldMint,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE', 'سعودي SA'],
    ),
    ProductModel(
      title: 'بلايستيشن',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.gamepad_rounded,
      accentColor: AppColors.accentBlue,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE'],
    ),
    ProductModel(
      title: 'جواكر',
      badge: 'شحن ID',
      category: 'شحن ID',
      icon: Icons.style_rounded,
      accentColor: AppColors.accentPurple,
      supportsDirectId: true,
      supportsVoucherCode: false,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'نتفليكس',
      badge: 'كود فوري',
      category: 'أكواد',
      icon: Icons.movie_filter_rounded,
      accentColor: AppColors.accentRose,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
    ProductModel(
      title: 'ببجي موبايل',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.sports_esports_rounded,
      accentColor: AppColors.accentAmber,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
    ProductModel(
      title: 'فري فاير',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.local_fire_department_rounded,
      accentColor: AppColors.accentRed,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'جوجل بلاي',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.play_arrow_rounded,
      accentColor: AppColors.emeraldMint,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE', 'سعودي SA'],
    ),
    ProductModel(
      title: 'بلايستيشن',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.gamepad_rounded,
      accentColor: AppColors.accentBlue,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE'],
    ),
    ProductModel(
      title: 'جواكر',
      badge: 'شحن ID',
      category: 'شحن ID',
      icon: Icons.style_rounded,
      accentColor: AppColors.accentPurple,
      supportsDirectId: true,
      supportsVoucherCode: false,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'نتفليكس',
      badge: 'كود فوري',
      category: 'أكواد',
      icon: Icons.movie_filter_rounded,
      accentColor: AppColors.accentRose,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),ProductModel(
      title: 'ببجي موبايل',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.sports_esports_rounded,
      accentColor: AppColors.accentAmber,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
    ProductModel(
      title: 'فري فاير',
      badge: 'ID / كود',
      category: 'ألعاب',
      icon: Icons.local_fire_department_rounded,
      accentColor: AppColors.accentRed,
      supportsDirectId: true,
      supportsVoucherCode: true,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'جوجل بلاي',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.play_arrow_rounded,
      accentColor: AppColors.emeraldMint,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE', 'سعودي SA'],
    ),
    ProductModel(
      title: 'بلايستيشن',
      badge: 'كود فوري',
      regionNote: 'أمريكي / إماراتي',
      category: 'بطاقات رقمية',
      icon: Icons.gamepad_rounded,
      accentColor: AppColors.accentBlue,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['أمريكي US', 'إماراتي AE'],
    ),
    ProductModel(
      title: 'جواكر',
      badge: 'شحن ID',
      category: 'شحن ID',
      icon: Icons.style_rounded,
      accentColor: AppColors.accentPurple,
      supportsDirectId: true,
      supportsVoucherCode: false,
      regions: ['عالمي / GL'],
    ),
    ProductModel(
      title: 'نتفليكس',
      badge: 'كود فوري',
      category: 'أكواد',
      icon: Icons.movie_filter_rounded,
      accentColor: AppColors.accentRose,
      supportsDirectId: false,
      supportsVoucherCode: true,
      regions: ['عالمي / GL', 'أمريكي US'],
    ),
  ];

  static const List<PackageOptionModel> packageOptions = [
    PackageOptionModel(label: '60 شدة', price: 0.72),
    PackageOptionModel(label: '325 شدة', price: 3.65),
    PackageOptionModel(label: '660 شدة', price: 6.90),
    PackageOptionModel(label: '1800 شدة', price: 18.40),
  ];

  static const List<StoreTransactionModel> recentTransactions = [
    StoreTransactionModel(
      title: 'ببجي موبايل - 660 شدة',
      subtitle: 'ID: 5192847361',
      amountLabel: '-6.90 د.أ',
    ),
    StoreTransactionModel(
      title: 'جوجل بلاي أمريكي \$10',
      subtitle: 'كود رقمي',
      amountLabel: '-7.45 د.أ',
    ),
    StoreTransactionModel(
      title: 'إيداع رصيد عبر واتساب',
      subtitle: 'مؤكد',
      amountLabel: '+50.00 د.أ',
      isCredit: true,
      isPrintable: false,
    ),
    
  ];
}
