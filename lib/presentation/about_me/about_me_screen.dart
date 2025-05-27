import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_portfolio/base/constants.dart';
import 'package:material_portfolio/generated/assets.dart';
import 'package:material_portfolio/presentation/about_me/about_me_screen_bloc.dart';
import 'package:material_portfolio/presentation/components/timeline_card.dart';
import 'package:material_portfolio/theme/theme_bloc.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_portfolio/utils/text_utils/title_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rive/rive.dart' as rive;

final aboutMeKey = GlobalKey();
class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {

  late final AboutMeScreenBloc _bloc;
  late final ThemeCubit _themeCubit;
  late ColorScheme colorScheme;
  late bool isDark;

  late rive.StateMachineController _controller;

  @override
  void initState() {
    super.initState();
    _themeCubit = context.read<ThemeCubit>();
    _bloc = AboutMeScreenBloc();
    isDark = _themeCubit.state == ThemeMode.dark;
    _bloc.changeAnimation(
      isDark ? Assets.animDarkBirdButton : Assets.animLightBirdButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    isDark = _themeCubit.state == ThemeMode.dark;
    return getMainContent();
  }


  Widget getMainContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 450;
        final isExtraWide = constraints.maxWidth > 800;
        return SingleChildScrollView(
          physics: isWide ? null : NeverScrollableScrollPhysics(),
          child: mainContent(isWide, isExtraWide),
        );
      },
    );
  }


  Widget mainContent(bool isWide,bool isExtraWide) {
    return Padding(
      padding: EdgeInsets.only(
        top: 34.w,
        right: 32,
        left: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          aboutMeWidget(isWide),

          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSkills(),
                SizedBox(height: 24.h),
                bodyText(
                  AppConst.aboutMeDescription,
                  color: colorScheme.onPrimaryContainer,
                  fontSize: 16,
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          ...getExperience(isWide),

          SizedBox(height: 32.h),

          ...getServicesBlocks(isWide),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget serviceCard(String title, String description, bool isWide) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Assets.iconsIcService,
            height: 32,
            width: 32,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
          SizedBox(height: 12.h),
          bodyText(title, color: colorScheme.onPrimaryContainer, fontSize: 24),
          SizedBox(height: 12.h),
          bodyText(
            description,
            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget getSkills() {
    return LayoutBuilder(
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
                    padding: EdgeInsets.all(12.w),
                    backgroundColor: colorScheme.inverseSurface,
                    label: bodyText(
                      label,
                      color: colorScheme.onInverseSurface,
                      fontSize: 16,
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildDownloadButtonAnim() {
    return StreamBuilder<String>(
      stream: _bloc.animationStream,
      builder: (context, snapshot) {
        final assetPath = snapshot.data ?? Assets.animLightBirdButton;
        return SizedBox(
          width: 300,
          height: 120,
          child: rive.RiveAnimation.asset(
            assetPath,
            fit: BoxFit.contain,
            onInit: _onRiveInit,
          ),
        );
      },
    );
  }

  void _onRiveInit(rive.Artboard artBoard) {
    _controller =
        rive.StateMachineController.fromArtboard(
          artBoard,
          'BirdAnimation',
          onStateChange: (stateMachineName, stateName) {
            final clicked = _controller.getBoolInput('clck');
            if (clicked?.value != null && clicked?.value == true) {
              _launchUrl(AppConst.cvDownloadLink);
            }
          },
        )!;
    artBoard.addController(_controller);
  }

  void onRiveEvent(rive.RiveEvent event) {
    var rating = event.properties['clck'] as double;
    print("rating value $rating");
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget aboutMeWidget(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: titleTextMedium(
            text : "About Me",
            color: Colors.white,
            fontSize: 48,
          ),
        ),
        _buildDownloadButtonAnim(),
      ],
    );
  }

  List<Widget> getExperience(bool isWide) {
    return [
      bodyText("My Experience", color: Colors.white, fontSize: 24),
      SizedBox(height: 16.h),
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10),
          ],
        ),
        child: ExperienceTimeline(),
      ),
    ];
  }

  List<Widget> getServicesBlocks(bool isWide) {
    return [
      bodyText("What I'm Doing", color: Colors.white, fontSize: 24),
      SizedBox(height: 16.h),
      IntrinsicWidth(
        child: Wrap(
          spacing: 1,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            serviceCard(
              "UI/UX design",
              "The most modern and high quality ui design with best user experience",
              isWide,
            ),
            serviceCard(
              "Mobile Apps",
              "Professional Android/iOS apps using native and cross platform technologies",
              isWide,
            ),
            serviceCard(
              "Backend Services",
              "High-quality backend support with Node.js and SpringBoot(kotlin).",
              isWide,
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
    ];
  }
}
