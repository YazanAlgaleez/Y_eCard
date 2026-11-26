import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:y_ecard/features/printer/cubit/printer_cubit.dart';
import 'package:y_ecard/features/theme/cubit/theme_cubit.dart';
import 'package:y_ecard/main.dart';

Widget _buildTestApp() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => PrinterCubit()),
    ],
    child: const TopUpStoreApp(),
  );
}

void main() {
  testWidgets('Y eCard home screen renders catalog and wallet summary', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    expect(find.text('Y eCard'), findsOneWidget);
    expect(find.text('145.50 د.أ'), findsOneWidget);
    expect(find.text('ببجي موبايل'), findsWidgets);
  });

  testWidgets('Category filter narrows displayed products', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    await tester.tap(find.text('بطاقات رقمية'));
    await tester.pumpAndSettle();

    expect(find.text('جوجل بلاي'), findsWidgets);
    expect(find.text('ببجي موبايل'), findsNothing);
  });

  testWidgets('Tier card opens LevelsScreen while account button opens History', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_buildTestApp());

    await tester.tap(find.text('جملة - مستوى 2'));
    await tester.pumpAndSettle();

    expect(find.text('مستويات التجار'), findsOneWidget);
    expect(find.text('المستوى الحالي'), findsOneWidget);
    expect(find.text('جميع المستويات والمزايا'), findsOneWidget);
    expect(find.text('تاجر مبتدئ - مستوى 1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('السجل والحساب'), findsOneWidget);
    expect(find.text('الطابعة الحرارية (بلوتوث)'), findsOneWidget);
  });

  testWidgets('Product details, receipt, and compact layout work without overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(960, 1920);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_buildTestApp());

    final pubgFinder = find.text('ببجي موبايل').first;
    await tester.ensureVisible(pubgFinder);
    await tester.tap(pubgFinder);
    await tester.pumpAndSettle();

    expect(find.text('معرف اللاعب (Player ID)'), findsOneWidget);
    expect(find.text('تأكيد الشراء'), findsOneWidget);

    await tester.tap(find.text('تأكيد الشراء'));
    await tester.pumpAndSettle();

    expect(find.text('تم تنفيذ الطلب بنجاح!'), findsOneWidget);
    expect(find.text('طلب جديد'), findsOneWidget);

    await tester.tap(find.text('طلب جديد'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('متصل: POS-58mm Bluetooth'), findsOneWidget);
  });

  testWidgets('Responsive and adaptive layouts handle ultra-compact and tablet sizes', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(870, 1740);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_buildTestApp());
    expect(find.text('Y eCard'), findsOneWidget);
    expect(find.text('145.50 د.أ'), findsOneWidget);

    tester.view.physicalSize = const Size(1800, 2400);
    tester.view.devicePixelRatio = 2.0;
    await tester.pumpAndSettle();

    expect(find.text('Y eCard'), findsOneWidget);
    final gridView = tester.widget<GridView>(find.byType(GridView));
    final delegate =
        gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.crossAxisCount, 4);
  });
}
