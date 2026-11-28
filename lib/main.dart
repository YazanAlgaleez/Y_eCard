import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_styles.dart';
import 'features/printer/cubit/printer_cubit.dart';
import 'features/store/screens/home_screen.dart';
import 'features/theme/cubit/theme_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => PrinterCubit()),
        
      ],
      child: const TopUpStoreApp(),
    ),
  );
}

/// Root widget configuring global theme state and right-to-left directionality.
class TopUpStoreApp extends StatelessWidget {
  const TopUpStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(showPerformanceOverlay: false,
        
          debugShowCheckedModeBanner: false,
          title: 'Y eCard',
          themeMode: themeMode,
          theme: AppStyles.lightTheme,
          darkTheme: AppStyles.darkTheme,
          builder: (context, child) => Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
