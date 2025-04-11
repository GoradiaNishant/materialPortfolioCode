import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_portfolio/base/constants.dart';
import 'package:material_portfolio/base/core_store/core_store_bloc.dart';
import 'package:material_portfolio/generated/assets.dart';
import 'package:material_portfolio/theme/text_style.dart';
import 'package:material_portfolio/theme/theme_bloc.dart';
import 'package:material_portfolio/utils/list_utils.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import 'package:material_portfolio/utils/text_utils/title_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final CoreStore coreStore;

  const HomeScreen({super.key, required this.coreStore});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: getHeader(colorScheme)), // Proper use of Expanded
        ],
      ),
    );
  }

  Widget getHeader(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.h)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          ...backGroundImagesAndOverlays(),

          // Scrollable content
          _responsiveLayout(colorScheme),

          // Theme switch
          _themeSwitch(),
        ],
      ),
    );
  }

  Widget _responsiveLayout(ColorScheme colorScheme) {
    return Positioned.fill(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTopMenuBar(colorScheme),
                    SizedBox(height: 40.h),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 150.w : 16.w,
                      ),
                      child:
                          isWide
                              ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 300.h,
                                    image: AssetImage(getProfilePicId()),
                                  ),
                                  SizedBox(width: 80.w),
                                  Expanded(child: _buildTextContent(context)),
                                ],
                              )
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 200.h,
                                    image: AssetImage(getProfilePicId()),
                                  ),
                                  SizedBox(height: 40.h),
                                  _buildTextContent(context),
                                ],
                              ),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Wrap(
                        spacing: 24.w,
                        runSpacing: 24.h,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildDownloadCVButton(colorScheme),
                          _buildFollowMeBar(colorScheme),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _themeSwitch() {
    return Positioned(
      top: 40,
      right: 20,
      child: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveThumbColor: Theme.of(context).colorScheme.onSurface,
        inactiveTrackColor: Theme.of(context).colorScheme.surface,
        value: context.read<ThemeCubit>().state == ThemeMode.dark,
        onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left:16.h,right:16.h),
          child: titleText(AppConst.appName, color: Colors.white, fontSize: 48.sp),
        ),
        SizedBox(height: 20.h),
        getSkills(context),
      ],
    );
  }

  String getHeaderAssetId() {
    final isDark = context.read<ThemeCubit>().state == ThemeMode.dark;
    return isDark
        ? Assets.imagesDarkHeaderProfile
        : Assets.imagesLightHeaderProfile;
  }

  String getProfilePicId() {
    final isDark = context.read<ThemeCubit>().state == ThemeMode.dark;
    return isDark ? Assets.imagesDarkProfilePic : Assets.imagesLightProfilePic;
  }

  Widget getSkills(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: Wrap(
              spacing: 20.h,
              runSpacing: 20.h,
              alignment: WrapAlignment.start,
              children:
                  AppConst.skillsLabel.map((label) {
                    return Chip(
                      backgroundColor:
                          Theme.of(context).colorScheme.inverseSurface,
                      labelPadding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w), // Adjust padding if needed
                      label: bodyText(
                        label,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontSize: 28.sp,
                      ),
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopMenuBar(ColorScheme colorScheme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child:
              isWide
                  ? Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(100.h),
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children:
                          AppConst.menuItems
                              .map((item) {
                                var isSelected =
                                    (widget.coreStore.screenIndex.value ==
                                        AppConst.menuItems.indexOf(item));
                                return isSelected
                                    ? getMenuItem(
                                      item,
                                      colorScheme.onPrimaryContainer,
                                      colorScheme.onPrimary,
                                    )
                                    : getMenuItem(
                                      item,
                                      colorScheme.primary,
                                      colorScheme.onPrimary,
                                    );
                              })
                              .separator(SizedBox(width: 24.w))
                              .toList(),
                    ),
                  )
                  : Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(100.h),
                    ),
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.menu, color: colorScheme.onSurface),
                      onSelected: (route) => {},
                      itemBuilder:
                          (context) =>
                              AppConst.menuItems.map((item) {
                                var isSelected =
                                    (widget.coreStore.screenIndex.value == AppConst.menuItems.indexOf(item));
                                return isSelected
                                    ? PopupMenuItem<String>(
                                      value: item,
                                      child: getPopUpMenuItem(
                                        item,
                                        colorScheme.onPrimaryContainer,
                                        colorScheme.onPrimary,
                                      ),
                                    )
                                    : PopupMenuItem<String>(
                                      value: item,
                                      child: getPopUpMenuItem(
                                        item,
                                        colorScheme.primary,
                                        colorScheme.onPrimary,
                                      ),
                                    );
                              }).toList(),
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildDownloadCVButton(ColorScheme colorScheme) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        shape: StadiumBorder(side: BorderSide(color: colorScheme.onSecondary)),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        backgroundColor: colorScheme.inverseSurface,
        foregroundColor: colorScheme.inverseSurface,
      ),
      onPressed: () => _launchUrl(AppConst.cvDownloadLink),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          bodyTextBold(
            text: "Download CV",
            color: colorScheme.onInverseSurface,
            fontSize: 28.sp,
          ),
          SizedBox(width: 12.w),
          _socialIcon(Assets.iconsIcDownload, AppConst.cvDownloadLink),
        ],
      ),
    );
  }

  Widget _buildFollowMeBar(ColorScheme colorScheme) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        shape: StadiumBorder(side: BorderSide(color: colorScheme.onSecondary)),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        backgroundColor: colorScheme.inverseSurface,
        foregroundColor: colorScheme.inverseSurface,
      ),
      onPressed: () => {},
      child: Wrap(
        spacing: 24.h,
        runSpacing: 24.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          bodyTextBold(
            text: "Follow Me",
            color: colorScheme.onInverseSurface,
            fontSize: 28.sp,
          ),
          _socialIcon(Assets.iconsIcGithub, AppConst.githubLink),
          _socialIcon(Assets.iconsIcLinkedIn, AppConst.linkedIn),
          _socialIcon(Assets.iconsIcXSpace, AppConst.xSpaceLink),
          _socialIcon(Assets.iconsIcInsta, AppConst.instagramLink),
        ],
      ),
    );
  }

  Widget _socialIcon(String icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onInverseSurface,
            BlendMode.srcIn,
          ),
          height: 36.sp,
          width: 36.sp,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  List<Widget> backGroundImagesAndOverlays() {
    return [
      Positioned.fill(
        child: Image.asset(getHeaderAssetId(), fit: BoxFit.cover),
      ),

      Positioned(
        top: 0,
        left: 0,
        child: SvgPicture.asset(Assets.imagesAndroidSvg),
      ),

      Positioned(
        bottom: 0,
        right: 0,
        child: SvgPicture.asset(Assets.imagesFlutterBird),
      ),

      Positioned(
        bottom: 60.h,
        left: 60.w,
        child: SvgPicture.asset(Assets.imagesCompose),
      ),

      Positioned(
        top: 200.h,
        right: 60.w,
        child: SvgPicture.asset(Assets.imagesKmm),
      ),

      // Optional overlay
      Positioned.fill(
        child: Container(color: Colors.black.withValues(alpha: 0.3)),
      ),
    ];
  }

  Widget getMenuItem(String item, Color onPrimaryContainer, Color textColor) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: onPrimaryContainer,
        borderRadius: BorderRadius.circular(100.h),
      ),
      child: bodyText(item, color: textColor, fontSize: 21.sp),
    );
  }

  Widget getPopUpMenuItem(
    String item,
    Color onPrimaryContainer,
    Color textColor,
  ) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: onPrimaryContainer,
        borderRadius: BorderRadius.circular(100.h),
      ),
      child: bodyText(item, color: textColor, fontSize: 28.sp),
    );
  }
}
