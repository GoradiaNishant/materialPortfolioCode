import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_portfolio/base/constants.dart';
import 'package:material_portfolio/generated/assets.dart';
import 'package:material_portfolio/presentation/components/show_case_widget.dart';
import 'package:material_portfolio/presentation/project_screen/project_screen_bloc.dart';
import 'package:material_portfolio/theme/theme_bloc.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_portfolio/utils/text_utils/title_text.dart';
import 'package:rive/rive.dart' as rive;

final projectKey = GlobalKey();
class ProjectScreen extends StatefulWidget {

  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {

  late final ProjectScreenBloc _bloc;
  late final ThemeCubit _themeCubit;
  late ColorScheme colorScheme;
  late bool isDark;

  @override
  void initState() {
    super.initState();
    _themeCubit = context.read<ThemeCubit>();
    _bloc = ProjectScreenBloc();
    isDark = _themeCubit.state == ThemeMode.dark;
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
        final isWide = constraints.maxWidth > 500;
        return mainContent(isWide);
      },
    );
  }

  Widget mainContent(bool isWide) {
    return Padding(
      padding: EdgeInsets.only(
        top: 34.w,
        right: 32.w,
        left: 32.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [

          titleText(
            "Projects & Works",
            color: Colors.white,
            fontSize: 32,
          ),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: AppConst.projectData.length,
            itemBuilder: (context, index) {
              return ShowCaseWidget(data: AppConst.projectData[index],colorScheme: colorScheme,);
            },
          ),

          SizedBox(height: 50,)

        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
