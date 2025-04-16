import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_portfolio/base/core_store/core_store_bloc.dart';
import 'package:material_portfolio/generated/assets.dart';
import 'package:material_portfolio/presentation/about_me/about_me_screen.dart';
import 'package:material_portfolio/presentation/components/top_menu_bar.dart';
import 'package:material_portfolio/presentation/core_screen/core_screen.dart';
import 'package:material_portfolio/presentation/project_screen/project_screen.dart';
import 'package:material_portfolio/theme/app_theme.dart';
import 'package:material_portfolio/theme/theme_bloc.dart';
import 'package:material_portfolio/utils/animated_switcher.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'base/constants.dart';

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

