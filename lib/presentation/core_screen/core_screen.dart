import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_portfolio/base/core_store/core_store_bloc.dart';
import 'package:material_portfolio/presentation/about_me/about_me_screen.dart';
import 'package:material_portfolio/presentation/core_screen/core_screen_bloc.dart';
import 'package:material_portfolio/theme/theme_bloc.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../base/constants.dart';
import '../../generated/assets.dart';
import '../../utils/text_utils/body_text.dart';
import '../components/top_menu_bar.dart';
import '../project_screen/project_screen.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key});

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {

  CoreStore store = CoreStore();

  late final CoreScreenBloc _bloc;
  late final ThemeCubit _themeCubit;
  late ColorScheme colorScheme;
  late bool isDark;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _themeCubit = context.read<ThemeCubit>();
    isDark = _themeCubit.state == ThemeMode.dark;
    _bloc = CoreScreenBloc();
    isDark = _themeCubit.state == ThemeMode.dark;
    _bloc.changeAnimation(
      isDark ? Assets.animDarkBirdButton : Assets.animLightBirdButton,
    );
    store.screenIndex.addListener(() {
      pageController.jumpToPage(store.screenIndex.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: PopScope(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  // Background image and overlays
                  ...backGroundImagesAndOverlays(),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 800;
                      if (!isWide && !isCollapsed) {
                        _bloc.changeIsCollapsed(!isCollapsed);
                      }
                      return isWide
                          ? Row(
                            children: [
                              sideBar(isWide),
                              Expanded(child: Column(
                                children: [
                                  // Padding for the top menu bar
                                  getTopAppBar(isWide),

                                  Expanded(child: getPageView()),
                                ],
                              )),
                            ],
                          )
                          : SingleChildScrollView(
                            child: Column(
                              children: [
                                // Padding for the top menu bar
                                getTopAppBar(isWide),

                                sideBar(isWide),
                                // Adjust height proportionally based on screen width
                                getPageView(),
                              ],
                            ),
                          );
                    },
                  ),

                  // Theme switch button
                  _themeSwitch(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> backGroundImagesAndOverlays() {
    return [

      ParticlesFly(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        connectDots: true,
        numberOfParticles: 100,
        particleColor: colorScheme.onPrimaryContainer,
        lineColor: colorScheme.primaryContainer,
        awayAnimationDuration : const Duration(milliseconds: 500)
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
        child: Container(color: Colors.black.withValues(alpha: 0.43)),
      ),
    ];
  }

  bool isCollapsed = false;

  Widget sideBar(bool isWide) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: isWide ? MediaQuery.of(context).size.width * 0.28 : null,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(30.h)),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: StreamBuilder<bool>(
          stream: _bloc.isCollapsed,
          builder: (context, snapshot) {
            isCollapsed = snapshot.data ?? false;
            return isCollapsed
                ? Row(
                  children: [
                    Image.asset(
                      height: 100,
                      width: 100,
                      getProfilePicId(),
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: bodyText(
                              "Er. Nishant Goradiya",
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: bodyText(
                              "Software Engineer",
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _bloc.changeIsCollapsed(!isCollapsed);
                      },
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        Assets.iconsIcDropDown,
                        fit: BoxFit.fitHeight,
                        colorFilter: ColorFilter.mode(
                          colorScheme.onPrimaryContainer,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isWide
                          ? SizedBox()
                          : InkWell(
                            onTap: () {
                              _bloc.changeIsCollapsed(!isCollapsed);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Transform(
                                transform: Matrix4.rotationX(3.1415926535), // π radians = 180°
                                child: SvgPicture.asset(
                                  height: 20,
                                  width: 20,
                                  Assets.iconsIcDropDown,
                                  fit: BoxFit.fitHeight,
                                  colorFilter: ColorFilter.mode(
                                    colorScheme.onPrimaryContainer,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),

                      SizedBox(height: 16.h),
                      if (!isCollapsed) ...[
                        Image.asset(
                          height: 200,
                          width: 200,
                          getProfilePicId(),
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: bodyText(
                            "Er. Nishant Goradiya",
                            color: colorScheme.onPrimaryContainer,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: bodyText(
                            "Software Engineer",
                            color: colorScheme.onPrimaryContainer,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16),
                        infoItems(
                          Assets.iconsIcMail,
                          "Email",
                          "goradianishant2000@gmail.com",
                        ),
                        infoItems(
                          Assets.iconsIcContact,
                          "Phone",
                          "+91 8320901498",
                        ),
                        infoItems(
                          Assets.iconsIcCalender,
                          "DOB",
                          "August 10, 2000",
                        ),
                        infoItems(
                          Assets.iconsIcLocation,
                          "Location",
                          "Ahmedabad, GJ, India",
                        ),
                        SizedBox(height: 16),
                        _buildFollowMeBar(),
                      ],
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }

  String getProfilePicId() {
    return isDark
        ? Assets.imagesDarkContactMeProfile
        : Assets.imagesLightContactMeProfile;
  }

  Widget _buildFollowMeBar() {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        shape: StadiumBorder(side: BorderSide(color: colorScheme.onSecondary)),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        backgroundColor: colorScheme.inverseSurface,
        foregroundColor: colorScheme.inverseSurface,
      ),
      onPressed: () => {},
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16.w,
        children: [
          bodyTextBold(
            text: "Follow Me",
            color: colorScheme.onInverseSurface,
            fontSize: 18,
          ),
          _socialIcon(Assets.iconsIcGithub, AppConst.githubLink),
          _socialIcon(Assets.iconsIcLinkedIn, AppConst.linkedIn),
          _socialIcon(Assets.iconsIcXSpace, AppConst.xSpaceLink),
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
          height: 28,
          width: 28,
        ),
      ),
    );
  }

  Widget infoItems(String imageSrc, String label, String value) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.all(Radius.circular(30.h)),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: SvgPicture.asset(
                width: 24,
                imageSrc,
                colorFilter: ColorFilter.mode(
                  colorScheme.onInverseSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bodyText(
                    label,
                    color: colorScheme.onPrimaryContainer,
                    fontSize: 18,
                  ),
                  SizedBox(width: 25),
                  bodyText(
                    value,
                    color: colorScheme.onPrimaryContainer,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getHeaderAssetId() {
    final isDark = _themeCubit.state == ThemeMode.dark;
    return isDark
        ? Assets.imagesDarkHeaderProfile
        : Assets.imagesLightHeaderProfile;
  }

  Widget _themeSwitch() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Align(
        alignment: Alignment.topRight,
        child: Switch(
          activeColor: colorScheme.primary,
          inactiveThumbColor: colorScheme.onSurface,
          inactiveTrackColor: colorScheme.surface,
          value: _themeCubit.state == ThemeMode.dark,
          onChanged: (value) {
            _themeCubit.toggleTheme();
            isDark = (_themeCubit.state == ThemeMode.dark);
            _bloc.changeAnimation(
              isDark ? Assets.animDarkBirdButton : Assets.animLightBirdButton,
            );
          },
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

  Widget getPageView() {
    return SingleChildScrollView(
      child: ExpandablePageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AboutMeScreen(),
          ProjectScreen()
        ],
      ),
    );
  }

  Widget getTopAppBar(bool isWide) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: TopMenuBar(coreStore: store, isWide: isWide,),
    );
  }

  /*Widget getPageView() {
    return ValueListenableBuilder(
      valueListenable: store.screenIndex,
      builder: (context, value, child) {
        return IndexedStack(
          index: value,
          children: [AboutMeScreen(), ProjectScreen()],
        );
      },
    );
  }*/
}
