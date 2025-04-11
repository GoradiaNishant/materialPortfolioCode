import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_portfolio/base/core_store/core_store_bloc.dart';
import 'package:material_portfolio/presentation/home_screen/home_screen.dart';
import 'package:material_portfolio/theme/app_theme.dart';
import 'package:material_portfolio/theme/theme_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ScreenUtilInit(
          designSize: const Size(1440, 720),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: CoreScreen(),
          ),
        );
      },
    );
  }
}


class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key});

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  CoreStore store = CoreStore();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, child) => Scaffold(
        body: IndexedStack(
          index: store.screenIndex.value,
          children: [
            HomeScreen(coreStore: store),

          ],
        ),
      ),
    );
  }
}
